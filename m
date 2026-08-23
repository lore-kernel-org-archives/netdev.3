Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA5F2D2385
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787499067; cv=none; b=Juf47+U03MYOzOXK5gn1aF8sbfrwQJ/hbNb4d/AQaA4b+nEHWRttOuAmvTz3mgU1JspyZXpPrqYExb0J2Mvklmjh01BtRMOUyMzzDkkXhTwIDOxcP35V8xmD8DoSt7o2RYpCchqMspujLibYT4f7r0xRVc4SCZOtjzIwrLL3GFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787499067; c=relaxed/simple;
	bh=1SmV4GAWVaKDGlBBkx/CVe5THeC+32nJJT7aa8OIq28=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NsIwIqOWxtBjvSqQT+amlKFwklYO7LOHadorhQVXBhyX2vDS7P2TzZcmkvduppxyNC2Q1KC85rLx9lbMFa8MagCi/9RfS4m2Cl/RJBwf8CGYxG6XX677w4ctUTbRUNs+zlxVafURLrJhpqeA5fIlsaGxGfkE2p2Zh/k5UVCob8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ft8QriC2; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft8QriC2"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e512a9a6bso117450685a.2
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 08:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787499065; x=1788103865; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aQSbGBkg2hlL5IZxR9KCqikO7JkTkJW5f+Shlcs4oWw=;
        b=Ft8QriC2Nw7FOuDOht9RzIwTiKjPMgeSmZx1dO+JDge/w4fVSyQpDMSav869zyWt8G
         MUWWecWDUxVJor7NxdyfN0WcSNd99HSBF1f1WfMWT/VFZ8S8dvrR22ZWTBqp0AGW6h6C
         jcorNgs+Q1z06rw4Nu3CG7x6foLuEOIB+47dYs3FBIRPdE5ASKRfBq5vRLeX2TPSapFN
         U51qJ3RsdlOrfNFbeJie5AX9D9pq5bRcvSTV//qVXZdqNXkJf5YedRVXdra7QBHKbGGU
         GBkzUE2NBzCnJk4pftNeTStki/597Pygc+bsb4WYwZk3tQFgWcHl6nj+DbA/Iuu9z086
         X0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787499065; x=1788103865;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aQSbGBkg2hlL5IZxR9KCqikO7JkTkJW5f+Shlcs4oWw=;
        b=qfd2ZcFS3b4ojPn0yza+PEPv/oC2j+dFHYWTjZiQoRrM/cBlxraL0XONEMUe4Jx3OZ
         BPAPwfgxgpPQUMN9BjRbDA8DNAhD8xfhSaP1rsnFH8y4HFPVpXBlaE2Vu7dUFNhCBOfm
         jtPG4WH7NeS41/E+/WWcJQLTGbgJVMNqi1BvppKqIN0fVVMpSAgc8xNb9EEx3KnpofOQ
         RhPad87iT7K7TwjzoJsdyzLHUH15am7XTYMhHqV2o8xthW9zu82C60iTN/G8E8elFldE
         dxSonnMWZB+iJ74RMBrUGtorCX8ArjaPUOqgU5vbULAiXLpL6CJ8mTBOKcOvv0Nz8e2v
         pF3w==
X-Forwarded-Encrypted: i=1; AHgh+RpMtgGXQBDI+yLA+V0Tn8kx4BIxhE89Z/nwLSw9VQvvrjUiffDjfIrpHus2n/LghCUOQ9tAobU=@vger.kernel.org
X-Gm-Message-State: AFuF++nYP7kFr6QkW/xXbS1yFY6lrzlvXBHwlRB6OhlilsIVAOzJ5L8y
	9nq2bZbnMXfpF7Jim/9XpueVF/3YDLWcZhwj5GcJmr8UaC3m6l9o4m9C
X-Gm-Gg: AR+sD13+qpBCEsi7+4fNcAnhgubX+32CDdT58143YIzvbquR+iNzq/GKOM1akaLtf2q
	KHHrY0uMhN2jZp5uTi7HUVAwlYKnb+nRwqrYFLwcOBldgUGqpGP4VLLQ8m25uoZyZyXO91BNbNQ
	Z+EEadBNWuDkNRXl8i02jMcYh8q15Q5uXLxTig9v7XXWKeQlyUR/lAfzjv03HqMMo6GaRdyTInc
	xlPZwvbBg+M9ujg/XRlKIv5HEkzAiqAKKpY7FwGvIczfGAk68NwZHLHOZcFg5CLUrbAbmhF6UuS
	WDh/otWtJcvfatJWscVezq9jcr+ZsvzOvzs1zxAnJg+bKtnIB1auYFyAVeAFAZ8adVn0gN90ONk
	tGNZtrLYoP3Q+CqtcsYv1l0+TDOnwRtWJDm647reFVSkhEe25SL9U0irBHo1X84TIxaS3Y91DwN
	7cR2i3xzaGG35grFxrwsP2Xr9dRTRDk/B3xqcbhEPENNIdX1KR1cQHtU42RzJxM61Jbg==
X-Received: by 2002:a05:620a:4627:b0:936:e748:271d with SMTP id af79cd13be357-937395a84b1mr1759102585a.40.1787499065066;
        Sun, 23 Aug 2026 08:31:05 -0700 (PDT)
Received: from localhost ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749abec47sm317396185a.1.2026.08.23.08.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 08:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Aug 2026 11:31:03 -0400
Message-Id: <DKWFJ9D12OPD.2ZLQHDM0276G4@gmail.com>
Cc: <edumazet@google.com>, <cratiu@nvidia.com>, <borisp@nvidia.com>,
 <kuniyu@google.com>, <netdev@vger.kernel.org>
Subject: Re: [RFC net-next 1/6] psp: steer Rx queues with the virtualization
 cookie
From: "Daniel Zahka" <daniel.zahka@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>, <daniel.zahka@gmail.com>,
 <willemdebruijn.kernel@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260822225524.2328465-1-kuba@kernel.org>
 <20260822225524.2328465-2-kuba@kernel.org>
In-Reply-To: <20260822225524.2328465-2-kuba@kernel.org>

On Sat Aug 22, 2026 at 6:55 PM EDT, Jakub Kicinski wrote:
> @@ -72,6 +90,27 @@ name: psp
>            Present when in associated namespace, absent when in primary/h=
ost
>            namespace.
>          type: flag
> +      -
> +        name: vc-steer-cap
> +        doc: |
> +          Device can steer received traffic on the PSP virtualization
> +          cookie (VC). The VC is split into a 32b reserved part, a 16b
> +          queue ID the sender is asking the peer to send to, and a 16b
> +          queue ID granting the peer's own request. Steering installs lo=
w
> +          priority rules matching the latter, which win over the RSS tab=
le
> +          result. Only needed for the rx direction; granting a peer's
> +          request is just header generation and needs no device support.
> +        type: flag
> +      -
> +        name: vc-steer-ena
> +        doc: |
> +          Directions taking part in VC based queue steering. Leave the
> +          attribute out of a dev-set request to keep the current setting=
.
> +          Applies to associations created from then on, existing ones ke=
ep
> +          the setting they were created with.
> +        type: u32
> +        enum: vc-steer
> +        enum-as-flags: true
> =20

Should vc-steer-ena be a connection level setting? Maybe it could go
into rx-assoc. The way it's implemented here, the state is already per
assoc.

> +Every driver has to carry the cookie, not just those which advertise
> +``vc-steer-cap`` - granting a peer's request needs no help from the
> +device, so the ``tx`` direction of ``vc-steer-ena`` may be turned on
> +anywhere. Drivers must ask ``psp_assoc_vc_tx_get()`` for the cookie to
> +place in the Tx header, and report the queue IDs a received cookie held
> +in ``psp_skb_ext.vc_req`` and ``vc_dst`` (``psp_dev_rcv()`` does this fo=
r
> +drivers which let the core strip the headers). Reporting is what allows
> +the core to grant the peer's request. The steering itself is only
> +expected of drivers which advertise ``vc-steer-cap``.
> +
> +When VC steering is enabled GRO implementations are allowed to ignore
> +changes in the cookie for transport mode PSP.
> +

Makes sense. Do we would need to update __psp_skb_coalesce_diff() here
then for the sw gro?

>  struct psp_assoc {
>  	struct psp_dev *psd;
> =20
> @@ -159,6 +233,23 @@ struct psp_assoc {
>  	u8 generation;
>  	u8 version;
>  	u8 peer_tx;
> +	/* enum psp_assoc_flags. Written under psd->lock, additionally read
> +	 * on the Tx fast path without it. A snapshot of the device config
> +	 * taken when the association was created, so that the header size,
> +	 * and with it the MSS, cannot change under an established
> +	 * connection.
> +	 */
> +	u8 flags;
> +
> +	/* Queue IDs for the VC, ours and the peer's. @vc_loc is refreshed
> +	 * from the Tx queue selection and goes out as the cookie's request,
> +	 * @vc_rem is learned from the peer's requests and goes back out as
> +	 * the destination. Both are PSP_VC_QID_NONE until something is
> +	 * learned. Written without the socket lock, always use
> +	 * READ_ONCE()/WRITE_ONCE().
> +	 */
> +	u16 vc_loc;
> +	u16 vc_rem;
> =20

Unrelated, but this reminds me: some of the other fields here:
generation, spi, peer_tx, have some reads/writes that probably require
READ/WRITE_ONCE() and maybe deserve a similar comment here... Probably
all bugs that I introduced :/

>  /* Encapsulate a TCP packet with PSP by adding the UDP+PSP headers and f=
illing
> - * them in.
> + * them in. @vc is the virtualization cookie to place in the header, 0 f=
or
> + * a header with no optional fields.
>   */
>  bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb, __be32 sp=
i,
> -			 u8 ver, __be16 sport)
> +			 u8 ver, __be16 sport, u64 vc)
>  {
>  	u32 network_len =3D skb_network_header_len(skb);
>  	u32 ethr_len =3D skb_mac_header_len(skb);
>  	u32 bufflen =3D ethr_len + network_len;
> +	u32 encap_len =3D PSP_ENCAP_HLEN;
> =20
>  	if (skb->protocol !=3D htons(ETH_P_IP) &&
>  	    skb->protocol !=3D htons(ETH_P_IPV6))
>  		return false;
> =20
> -	if (skb_cow_head(skb, PSP_ENCAP_HLEN))
> +	if (vc)
> +		encap_len +=3D PSP_VC_SIZE;
> +

I suppose vc of 0 is probably valid. We might need something else to
disambiguate "not present".
