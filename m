Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FC84CCDDF;
	Thu, 24 Sep 2026 17:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272008; cv=none; b=F/OPAoltJt3LkqAL2qaz2t/go7jWm2Y7j//x/6YDSegnttmaYGPY1IIce0IoQxS5PRK8sYjWcebdfcbi4Pb8ZfvvCzE8hKN/rEqNzGvFTaw17uWZ6hB/2Otg9WyVKmmpT5foOTKu48YhrbuEWqoM+SG631JbU2H7uulQTwzMNzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272008; c=relaxed/simple;
	bh=NdlIP5k0zy8YqoEinakvl1zXvMFpKgO67bx90z/m6O8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dy8rR2AbBye8zPL3RJzbgFZNgFJlPi8k7qwVD5r7PSjADPUvpuHe1jiiMU0Pc5F9krTfUeDVVWqbE2pnqt5Obd9j4a+mtF60gaUErIECdsRM1rKVN6LOSRYjjmSNCElWqB29IPbYbJOf/Zx/7PnzK0LUmW2fTV9tDNy61AegevU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEoa+YVS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEoa+YVS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBF71F000FF;
	Thu, 24 Sep 2026 17:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272007;
	bh=WcyHyzV8NxmGIRpq3KuKTXbjCp/07lHrPqYcfM1X3Sk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bEoa+YVSMGTXNxZDtl1bbWHYD2dRqYejJWhFOe/SqINwO4hzzHOEpHSD/jE6wcMiJ
	 wFbzUvLkPTaI07L5IWwpworUtaUOEq/3QI53LYiHt4ZM/Tb0SfbyB1UY5WEOHaWJjn
	 G3un/nB3gDnxU2hTYDEREodonMzMOFyEgR+VpikdyIdbRMgL/rGp8fnjcXZ+qmleO7
	 Dj8t9qo+oy6GfSt7mw67ZlUYvDnXdjPlEIeBgsACKXUo46V5FBb1CgiQiyJ+jU7w1e
	 XIAD0le3haf2dG4/EJrYf54fPu9j/egLi1kSmttOeM1gadqBIjfXnPms6I5cFii1fO
	 +gh6RuieOOuUA==
Date: Thu, 24 Sep 2026 10:46:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagar Taunk <sagartaunk@proton.me>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel
 Almeida <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Matthew Maurer
 <mmaurer@google.com>, Carlos Llamas <cmllamas@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [PATCH net-next v4] rust: net: netlink: validate attribute
 length before casting to `c_int`
Message-ID: <20260924104645.4764dbba@kernel.org>
In-Reply-To: <20260923120504.9100-1-sagartaunk@proton.me>
References: <20260923120504.9100-1-sagartaunk@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 12:05:17 +0000 Sagar Taunk wrote:
> Rebased on the upstream rust-next tree. 

I'm confused, you're tagging this for net-next but rebasing 
on rust-next. This patch does not apply for us.
-- 
pw-bot: cr
