Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449016;
	b=2oz8DIdYyKcyQlCXnJP1LG/etR2MnQJbUdbGNP5HSHxoZTdurFZA/bQ4nD1X8pser1kq
	 pVDBX/8mzuF1/XGTqqdkGPw/g4mHl3oMF+hQkkwwCso6vQhWMvQV/NhWRvAUxE42rWBkr
	 dm9YQ1VdVhslWI8P99788ceoBmZy56f+Gap551WEaG2g/0IbP7fBb/2nFkdv4Z5mFtsIZ
	 Oq1GXRauwKJy6+BAv1L+IAGJSEeEPPC6Q4qxyR4YPfRN0mskGJrC0FR9aud3215Z7Vbbl
	 KBdZjdEUstKG3PmPBJ6eUEXyiOTd7S7kVzYbaf/DCKLaVjeeOl78riFyYYmBvFena9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449016;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cZ5a6HktCXoFhMOCk5P8LsZ8uayaKnzjegSFz3zFWHk=;
	b=JmXIlLSJUTyXzFeijJnzJ+RO0xo/M5TFuSTyjRvoBRFC+pEB34C7o6DGEHQyGLvYxfPB
	 80g9FrYkW92cn8hqPSN6r72YnlmTYUIKPiz36+LC0XmAUbnZixW6OB8vbFwzUUtTlusT4
	 5ha8g4c7cu+Z77OD2kDhHabVtIzvZTnMbFAORGCjsSWKBFiMHV13CfDn28wbxyvjPmwxk
	 QDbjXAwWezHrh407ksqrJuifoGVv8xjcs+8TI5EA0+bLX3wsqDjYLQZXnDYomd5yv1VEa
	 pgKUQbliUCQ7Jdzn1mDFxmF9b8ABGN6GiRb2TYENlc9d2GuInPdebCESMpC06dn3xug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5qV+5wr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0326606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5qV+5wr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEA91F00A05;
	Thu, 12 Nov 2026 02:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794449016;
	bh=cZ5a6HktCXoFhMOCk5P8LsZ8uayaKnzjegSFz3zFWHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W5qV+5wr53OQTIS2vtYSF5BrrleP7N0RUjH04JOmuqKRiWkgzVf/riCYGNuvpz2BS
	 W37hhs1JJMwSsUQqNwHVugTKWyU7KiiX8LFHLURz5Cms9ZxlWMGQw3rdqEtgIiIIkU
	 /qT+wlRHuftPlifNpJg1CpSERuf6sz3q9PAAxSZtljXMRvkbbTsezh8rkoqSj+86yu
	 uFUkO9JyArHRzLbZM8jgGd1XFJivtjnI/oKoQAZVfE+xTlYJxNc/hHltVTkY08bdiN
	 18IfwGRgchyJ2YvXzDyiKgO7zc0JrAKk0Pu0cYiHkp09Y/DmkFNT5zLq5I9DFntpiD
	 Pm8DWLE1RTwfA==
Date: Wed, 11 Nov 2026 18:03:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: houminxi@gmail.com, netdev@vger.kernel.org, donald.hunter@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org, dev@openvswitch.org
Subject: Re: [PATCH net-next v7 2/2] netlink: specs: add ovs datapath and
 vport set operations
Message-ID: <20261111180335.26ecd709@kernel.org>
In-Reply-To: <179444894679.2199510.3381591546922833179@kernel.org>
References: <20261110174751.973464-3-houminxi@gmail.com>
	<179444894679.2199510.3381591546922833179@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 02:02:26 +0000 netdev-bot+sashiko@kernel.org wrote:
> > @@ -102,13 +102,17 @@ attribute-sets:
> >        -
> >          name: masks-cache-size
> >          type: u32
> > +        checks:
> > +          max: 4096  
> 
> [Severity: Medium]
> Is 4096 the right bound on every configuration? 

Just don't add the bound if it can't be easily expressed.
We are not planning to code gen the policy anyway, AFAIU
