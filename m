Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792718985;
	b=B/Gr0XaC2ACh4CPoaQdm03DAks77n3ICIB6NiGcHLrq/E9Rk+7nK12KhLbZQcDYQGYRo
	 dPxKtJNJmDZ7ooOio/fsblOLNg6RrBj9+rPhkjVn9XA/snvhmr9gfekBfGyDpGodzBpFV
	 brm7eEXIoQvc20m8zQFeJm8gVm2WAqpIvwrsW4lsY5TKXCDmPuhRCiN76EwRv9+VUq6+t
	 6ZTYCGI0DRYjpYiTu1RVxx+zmb5asOucvMYEu7eQsWi0szDqBTTr3HZ8TkSA4V82TZCbo
	 x+2B3fe/BI/cjGueOctHQb+DvHt1a7kjPuErdT8hP1IQAhg7WupHESFxhDOSP/ORQwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792718985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=C+nC5H5YCfNwEFpwYdCQlf4IRtm9LjspZk5HnuCZBWg=;
	b=PDTyKoQyXfCvOT40lChZSrVL37I/Uv4wLI8RwLFZ0u4T0eyTNANlSpYiK1Z9wNG0CY0N
	 PQRDmrWiRsh0crNNHW+00DDKvoH0gjg15G3moGtqgpMwRClpQKThb8gWFTgsUDoEueI8d
	 8+86stQWUP9xReW4OClqPGmft64d1INLoaAnK0SZLO6LO1TE3HVdPR8aaTVdIRCd0qfQa
	 II92tsXSuQM68MSKUpIMqCLhdU3qUkRGKQTOKBerXnjZWbiiyBNioBYsUtkW/o44a80Zv
	 lwnxJ4Bzv7wzbAZaC5exnYmkIHEVdCP83LOPIxSG6WxQDW096ueFhV84n5qzfg3V1HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Akbg1euf;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF4B606A319
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEF4B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Akbg1euf
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ead32bc7d8so368245e0c.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 18:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792718984; x=1793323784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C+nC5H5YCfNwEFpwYdCQlf4IRtm9LjspZk5HnuCZBWg=;
        b=Akbg1eufe7ZMs4AAkRO+qnMuJKJQ9WmLW4ZGnD7hrGeQryhmxUkMoN+s35rFJjU7aR
         OEOVlQjlLtChfXY0Gd+M9PVFPsuo9k921CPk9Vf4hosq1qzL0zpDXuFhi3/8VsfWZeQJ
         bhY+mTsftZgwVs3HTFAw1bd7zyHtGmSUFK/BhwutPdYoun104/+l2JFnxnTxV+eeKDWh
         JVlOvqOZkuWj/kfgdfTrTcAPsRuZRUFm3ZKgykhBlPQ19TPc+BEyWn9/jW8WW3ouKwnl
         4Sbj4U0Ii+VobypOIEOBt4XBQb9W85rMdVlV7DzpnBuNRhOTmMLDrrRVHAGIkMaIJsPq
         B1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792718984; x=1793323784;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C+nC5H5YCfNwEFpwYdCQlf4IRtm9LjspZk5HnuCZBWg=;
        b=EssCOephCmacV3bUuwHOfx3mNBQK+uuOKjmqSdDfv9dKe5HBv83+5aH/lA9ijFiUU/
         y1EGJYLyaddb1J9jw9/fo5b7LiG01GnL8r+6BiJxpu/CchOTCJxBEx/eEA1a38NL+/W3
         X2t0lwFHaumMtjy5SaKbHiDp513uuIXGSp4IIqivsptHfJXiHRqwYlgAjIy6/0q55C/J
         WAa+LPh76wZdeewoC4EUccDzeSOxRFNHCZYft0+nXK40UrE1FCIUyKh1uzI6fw0+phWf
         nYohvuIUIcFFCpGDl5u0hQ//9NXKLe+LtmGbAQClmI4B8+k2h9+ANcC+80baNYXOaIoU
         jVrA==
X-Forwarded-Encrypted: i=1; AKwUvBypRacVkJGtpbSC1jwEtlBzZxrJO3EY01dcRcu2lwZQnILD+8gJV75bVvesd6jr5GcEgwJaFjM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXUYaxnnHVjSv6b4qh1d56ntp17Pm9LI6Gur5dqi9KgxdV+RO+
	fEZe2wp/gUJtLQYKF4RwPK71M2CuLvnmNZHkU8s9JV+bJvV/W3HgcKhL
X-Gm-Gg: AYBFou0YKNW9tBGW4OkSSrYrOkrra6opbolSMXBM9gJDycDw9PmUHDplVv/EO749qw3
	kf6EdxkTEb3OMKgJMlu6whI6t7V6kdoYrmlwa4FdeDiXqgO+9Ztqzam+q23arp+hpjh7jYGp0+v
	LJfIxpOGUOhN+OuQCYJdrugqq8EBNQc9LNCizyfCST0EoZ3fKi2XKoRm2zWiMeBcleOOej28Mar
	mquAFvABDgk+1dKUCCbzTme/EDtYwawDd8i9cI26hVuxgk/ZLX/7OkeS+j9w8sPrUhlAMICJGle
	NMAcq8yQbXE7N6P7fA+NGKQ2RC67YlZJq9O+xrTN9ovt64mqRXy9MqVgA+EJpE7dZA2tAEd5Nrl
	dmVj7U4h+0NJWCWdZMteX3tU6lCCLziqBGCOUjRN3zMWKTKjsIaeiJ1OW2/FE4qlKA+9ukAZlZd
	o+vCd+6zBkDWe6jFqKMxT8nXMMofTgGVzcGLcdX77weV6aLVA1X0uhM7w8M3zdMTA5rOt/6Ap+b
	qJfsgx1bncLR6sFD2OIOlTwhR07ZRiTBdsE0c+mgbLwGmaVwbyn7pcV/to69CGY8NNwrO167cSq
	SwGwkpEO5yPanjD/8Qh4zlcvbSbZLCdhnUur5qJjOmSKN4U6LNW2V2g0z8vt0TK5LXFR6hoWgIb
	rxiqVxuKAI8lS1OSPwaWLMbixF14bud/z2wNKMbD4
X-Received: by 2002:a05:6122:4909:b0:5ea:cd69:7cda with SMTP id 71dfb90a1353d-5ec14a6ff12mr259838e0c.7.1792718983957;
        Thu, 22 Oct 2026 18:29:43 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec13f0fb63sm919521e0c.12.2026.10.22.18.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 18:29:43 -0700 (PDT)
Date: Thu, 22 Oct 2026 21:29:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 shaos <shawnq1@163.com>, 
 Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <willemdebruijn.kernel.2d936272e7d49@gmail.com>
In-Reply-To: <20261022120246-mutt-send-email-mst@kernel.org>
References: <20261022155436.117507-1-edumazet@kernel.org>
 <20261022120246-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH net] net: harden qdisc_pkt_len_segs_init() against
 malicious GSO packets
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michael S. Tsirkin wrote:
> On Thu, Oct 22, 2026 at 05:54:36PM +0200, Eric Dumazet wrote:
> > An SKB_GSO_DODGY packet can carry untrusted gso_size and headers.
> > 
> > For instance, gso_size=1 and hdr_len=65532 for a 524275-byte frame
> > makes qdisc_pkt_len_segs_init() compute an accounted length of
> > about 4,294,574,091 bytes (after gso_segs silently wrapped in a u16).
> > 
> > With DRR quantum 256, the dequeue path then needs ~16.8 million
> > deficit refills before it can dequeue the skb, keeping the CPU in
> > the qdisc path long enough to trigger the soft-lockup watchdog.
> > 
> > Commit 8f735d64382d ("net/sched: bound qdisc_pkt_len to prevent
> > qdisc soft lockup") added QDISC_PKT_LEN_MAX to bound size table
> > amplification. Use the same bound for DODGY packets:
> > 
> > - Make gso_segs a u32 and drop packets whose segment count does
> >   not fit GSO_MAX_SEGS, instead of silently truncating it.
> > 
> > - Drop packets whose estimated qdisc_pkt_len() would exceed
> >   QDISC_PKT_LEN_MAX.
> > 
> > Fixes: 15e5a0307164 ("net_sched: better precise estimation on packet length for untrusted packets")
> > Reported-by: shaos <shawnq1@163.com>
> > Closes: https://lore.kernel.org/netdev/20261022144755.65025-1-shawnq1@163.com/
> > Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> > Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> 
> I'm all for stack being more resilient.
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
 
Reviewed-by: Willem de Bruijn <willemb@google.com>
