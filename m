Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2EA1429D;
	Tue,  8 Sep 2026 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828695; cv=none; b=Plda9pqcTOvcWsbsZP0tdWp5ZiJ4tocXveVjl/QlCgVkp+0jE6YvJnNn34Nnscg8+MVQeDPK0FQ0O5V4EhMGOlU86XtRb9pbGiGr/fotU8DAmbLbcdV3uydANpuJnkrLxg5ps5IoobOcGwAKJuG4A96iR36B2V6WuC7HgAY4sq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828695; c=relaxed/simple;
	bh=4ow+qkKFz5takrDgLK3I4jp2gyVc8w6dvsOzx9gt5bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NcfsdR9VxhbCOl+GCJcFfems3U0KHq6RwrQSnAO/KMn4o4T/dzWLv2J191agqJH917H1az8BQpPFGQ19t08wRak1lOLrrjwYOze+xYbzPRP6N+WC7x/m19EXJE1usZ0uUWb2DLBDY1z+ritEQpSBsjxDHqsld7gmgh/O4prB9Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot/MgIhM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot/MgIhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8D91F00A3A;
	Tue,  8 Sep 2026 00:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828693;
	bh=KBKu9xxMWfHQEXgjrCowkbDaC2dsLuQ+wtsDf3EJ6Fs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ot/MgIhMCwyXB9Tz36MxR3Ba8+Y8XjL4tVO49FAtKAR7PogHsW2QgF5gtcaspFXsr
	 /0N7d2fdyipbK3tzf4Y1jjWnxIfKE8adCRdPYq7nJCXuD9zO7okaW3wkjfG3jLm8y0
	 247MFcnYHYnSEu1+wFnwABhSdZa6FMHhyXxEe3l6zqcJRqm3aEG69LYb5ntrzyeg80
	 lBHNBB1ZdNSmoYT3pLBeAdNFFPhLXHFlo/EbJ6xmVD+rQHUM7RSPxOFnGNPAlclgKr
	 G+8w20mDjGGalLzdMiq9/eNqneSueDZx4jzagOrYEZpUtCWJkJIR01if7zs9plYCiX
	 HzZDsc18Piijg==
Date: Mon, 7 Sep 2026 17:51:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuang Wang <nashuiliang@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Stanislav Fomichev <sdf.kernel@gmail.com>, Hangbin
 Liu <liuhangbin@gmail.com>, Samiullah Khawaja <skhawaja@google.com>, Neal
 Cardwell <ncardwell@google.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8] net: reduce RFS/ARFS flow updates by
 checking LLC affinity
Message-ID: <20260907175132.7fe9323a@kernel.org>
In-Reply-To: <20260907174715.0c00501d@kernel.org>
References: <20260902025203.4741-1-nashuiliang@gmail.com>
	<20260907174715.0c00501d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Sep 2026 17:47:15 -0700 Jakub Kicinski wrote:
> On Wed,  2 Sep 2026 10:51:50 +0800 Chuang Wang wrote:
> > Subject: [PATCH net-next v8] net: reduce RFS/ARFS flow updates by checking LLC affinity  
> 
> When you repost v9 please dial down the slop in the comments 
> and the commit msg.

Also not sure why you're trying to touch RFS, the change only helps
aRFS and you could avoid bulk of the refactoring issues.
