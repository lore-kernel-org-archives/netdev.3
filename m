Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DFF284662
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663823; cv=none; b=eZA7YXacN0O9yh+/dimqGN5nqJvIHvXouLAhy0wzL2xuSNDAZKKc1MRd7+yZZ2sK49Ql5KMuAQoVsuEOFCkL7DXlSDUefGNKEBpBcKuXpckCVrLIEc29zGix5Gj7TmyM5WFpRLcC8bPBb1+H9lWTcWWdORQXuZ2dutPRVAMP3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663823; c=relaxed/simple;
	bh=klmlID2EajsAvJ3IV6Y8fCAl/siCNBmyn+r8EkPp48c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3lzMzREjvwSYuqWl7ac8bDfCUhwTgCY0lmCTTuKhEJGaNvxlRuOrzNbhkhoIl2Q34UufTRjmKzQvD8x2ApD4ruWElLHe8NZItoY3/ZluCH40JdJpJY4WW1thcWWQdDMqs9g7qZr8heZLLRxDyH7PrfzPKLK6JwA8zfntgBlEWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXRXjR1y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXRXjR1y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2998D1F00A3A;
	Tue, 21 Jul 2026 19:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784663822;
	bh=XDte+dsGmJaWCxb1SmbhyM+ZQVBwR/9EV9g8/+L++G0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fXRXjR1yoOgQQorgaze6RrJ/YWPQQzAh7MgEaXx/IpbaNDQ9CNm3R+60aNTw6O53u
	 mD/P+r+06spuNazWl84cSn5IMedirPpVhRB4WpJd66cNMq+yMCcYVVrS7VE84bgL6j
	 UBWwLorDjQk1CJbTZAlpEtYOLBxrjypkYwBrz77ymix7Djlp76q8xcsScTk2sg14/e
	 UFcYX88i3Kop5pQeR6ZAzqgKOKegRMFgKmWiYFAvDtyPktUuODiDlYyCBMSnRiGRob
	 Qpc+9AG9mBgjvvV2I2FUQ2If9UxIeRNJr9hoKTX+9kzZd/J/wNrKJJwXRdNUF2NURs
	 oOLuGXpjgIuVw==
Date: Tue, 21 Jul 2026 12:57:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
Cc: <netdev@vger.kernel.org>, Brett Creeley <brett.creeley@amd.com>, Eric
 Joyner <eric.joyner@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jacob Keller <jacob.e.keller@intel.com>, Simon
 Horman <horms@kernel.org>, "Vamsi Atluri" <Vamsi.Atluri@amd.com>
Subject: Re: [PATCH net-next v8 0/6] pds_core: Add PLDM firmware update and
 host backed memory support
Message-ID: <20260721125701.76ff7fd9@kernel.org>
In-Reply-To: <20260721-upstream_v8-v8-0-1ea9a8b7c4ff@amd.com>
References: <20260721-upstream_v8-v8-0-1ea9a8b7c4ff@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 19:13:08 +0000 Nikhil P. Rao wrote:
> This series adds PLDM-based firmware update support to the pds_core
> driver. PLDM (Platform Level Data Model) is a DMTF standard for firmware
> management that provides a vendor-neutral interface for firmware updates.
> 
> The implementation uses the kernel's pldmfw library for package parsing
> and component matching. Users can update entire firmware packages or
> individual components via devlink flash. Component information is
> displayed via devlink info, showing firmware versions and update status
> for each component.
> 
> The series also adds host backed memory support, allowing firmware to
> request memory pages from the host for its operations.

Looks like this series conflicts with the fixes I just applied to net.
You will have to rebase and repost. Sorry for the vacation-induced
delays, it is what it is.
-- 
pw-bot: cr
