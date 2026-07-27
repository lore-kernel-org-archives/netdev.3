Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FC73845CF
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162230; cv=none; b=URajJ8hJJJJVOBbG0Zpwv6/laGagqayLi3/SEK1o7C+Bd/sZlLLkuXCnr6Lss6ZCg66v8HVtGzXQx39OQjhX2Y1aaJwGADvq3U0wZZxXXFDtrffQBJ7HFHur8AHuMUoSlw5PJ/0Jubyg8eW0wy9jjyLTiJye5XH+QPtFsSoSnD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162230; c=relaxed/simple;
	bh=zWNmRw0tdrfgtF8saqtc0jjAxfPd6fmLK6erat3inE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htgQcfTL/0QbTa5Xgk1jso5ysweUzSpiOufTLiIlM4i/KfVeG4o9kagD/GHDFZBhpA8gOEHn6934DrfoJE9qjwD32i4DIkIArr6wtzHGCSmBJf0OVI152CXOfRZ2DH4sB3fnke/wul5aUrjsVJGB/Lxej8djinwOLY1jAEl5uEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=eHFArjdR; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="eHFArjdR"
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id C99C66018F;
	Mon, 27 Jul 2026 16:23:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1785162225;
	bh=b8PqiTTkmEl9nyriMpFyyfj2wkHdNtBSiU5R8ZC/vCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHFArjdRAa5gKAHJJ9pFCF2bJtk8+0ZA54w9gzNHLkbvSzATTR4o8v5j2x9wT5A57
	 aAF1cYCs1N9m4cmVFVLHeXU4dP3jkACb6DgoTdJimPAPaFHJGZyT6kYfNC5rrTeyKw
	 xDBX5LPjRl5XSrbE1GFazl4+DC1Pz4E8W8IWInmYqUu557iYNZdr6O5WVWlcDbu6fi
	 L+Z8ZZeAnWTcB2XbyXD5xg1JWHlKsmUFtUc+vW0lmk03hJ5JgQHS433Stxq3+PBsZa
	 fzoDqRG/2hPTLUqBneYqb/lUkaQcV4jpuNQP4Xgc+4Aj/g7vIHzg/gELKkhC4du0g+
	 ph+9KD3CGN5oA==
Date: Mon, 27 Jul 2026 16:23:42 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: devel@lists.linux-ipsec.org, netdev@vger.kernel.org,
	tobias@strongswan.org, eyal.birger@gmail.com, antony@phenome.org
Subject: Re: [PATCH net-next,v3] xfrm: allow to enable udp encapsulation
 without userspace socket
Message-ID: <amdp7nY5kjatDzVx@chamomile>
References: <20260717110118.251866-1-pablo@netfilter.org>
 <amdJCg3QqOrO_4Bx@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <amdJCg3QqOrO_4Bx@secunet.com>

On Mon, Jul 27, 2026 at 02:03:22PM +0200, Steffen Klassert wrote:
> On Fri, Jul 17, 2026 at 01:01:17PM +0200, Pablo Neira Ayuso wrote:
> > It is currently not possible to enable UDP encapsulation in xfrm without
> > a userspace process that listens on the specified UDP listener port in
> > the SA.
> > 
> > People have work around this by creating dummy userspace daemons such as
> > the one in the smallish perl program (see the script at the bottom of
> > this link):
> > 
> > http://techblog.newsnow.co.uk/2011/11/simple-udp-esp-encapsulation-nat-t-for.html
> > 
> > This patch adds XFRM_SA_XFLAG_UDP_ENCAP_SOCK to create the UDP socket
> > from the kernel.
> > 
> > Use a hole in net->xfrm to place the new encap_socket list.
> > 
> > The following example shows how to enable the standalone UDP
> > encapsulation:
> > 
> >     ip xfrm state add src 192.168.10.10 dst 192.168.10.11 proto esp spi 1 \
> >             encap espinudp 9999 9999 0.0.0.0 \
> >             if_id 0x1 reqid 1 replay-window 0 mode tunnel aead 'rfc4106(gcm(aes))' \
> >             0x1111111111111111111111111111111111111111 96 \
> >             sel src 10.141.10.0/24 dst 10.141.11.0/24 dir out
> > 
> > and the receiving side uses 'extra-flag udp-encap-sock':
> > 
> >     ip xfrm state add src 192.168.10.11 dst 192.168.10.10 proto esp spi 2 \
> >             encap espinudp 9999 0 0.0.0.0 extra-flag udp-encap-sock \
> >             if_id 0x1 reqid 2 replay-window 10 mode tunnel aead 'rfc4106(gcm(aes))' \
> >             0x2222222222222222222222222222222222222222 96 dir in
> > 
> > This allows for multiple SAs using the same listener udp port.
> > 
> > This is useful for testing scenarios where UDP encapsulation is
> > required.
> > 
> > Note this patch exports xfrm6_udp_encap_rcv() just like
> > xfrm4_udp_encap_rcv() otherwise linker complains due to unreachable
> > symbol.
> > 
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> Sashiko found some issues that look valid, can you please check this:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20260717110118.251866-1-pablo@netfilter.org/

Yes, I will follow up with v4.

Thanks!
