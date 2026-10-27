Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117620;
	b=QcJhozbdNnSWpdqacGSOfdklpHERz/+XsyptEn9tAW464doLgrc7ljyEge4Ew3x7/8b7
	 o83amVJajAeQ+Xfk9Mf67jHswVFaqudUlvOXIKcWNKoArRfQdAkvJ5OzKjrCUWVOovMhr
	 l1lXMxLnzwzQQf+Hz37ezbsTLyKbhG5PPfYOPLnFkoofU+JyEta1uNu1CaNQoKRKDlJdP
	 80RAGQuKWz2tBy3nV52RxILsBGODsvjBimJLjkqpyo88M1WZYlhduD53EyWgUucRFzsA9
	 mTl0jvtH1F4TA8iv7vXFavgnrzpfp56UbQQgb2rjKQ9gTXHYxG2iPfwnYk9Sja50npQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117620;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=MqwK0YNWl2/NE02weyhM1oThtkALeRvG2uaLxIj0uRA=;
	b=OzJ6Q1tn1HtDakWCqQB3d4TfSDDelym4W/IGy2spMxbc+UAtrpEohWogTcMMaYLn0+Pu
	 J3sxsGM/FRGfzrV24r1lHIDuyAlrnjzWvy6Gs426OdM5MdUmo53nnj7R5Grh3Fq4W22uE
	 XoE0hmS3KpQP0PeCPXK9hSDDrQ6QZF5iW/CiKG1fLJzxvkxFWES+05WafUkKu0HFQkuwB
	 B01bR3FJBiz/u3E3ZETlJ0QttgEgapjRqf8nN0hNpemhv4Lcsos7lG+qVmrlpQtGpztSL
	 E9JSHb5O3rR58Y5IwULKjAK4OIbZRrNAVHd4Zi7rgWvKurzvRoLxa3IK0PNjO5RsRZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=1g4.org;
	spf=pass smtp.mailfrom=1g4.org;
	dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=K4K6HT91;
	arc=none smtp.remote-ip=185.70.43.20
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B08606A31A;
	Tue, 27 Oct 2026 16:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6B08606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=K4K6HT91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail; t=1793117615; x=1793376815;
	bh=MqwK0YNWl2/NE02weyhM1oThtkALeRvG2uaLxIj0uRA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=K4K6HT91ZSvpF239LDUA/XsXhFzCLcbafpzOOQ/XVAEjKD0JE+Biv6mxBOqa74kIu
	 2/Xfu1zVu1iSCM1MzhExGAeCJVg8ZlUCIPa0C+9XiFeDZcujeweWS27QkbHjcvCAos
	 yIolSMEKjQtGMXKWEwPrv87O92ib+27TV4gd4mbETVJ/MjwGMRFAUMhQtcBJZBazuP
	 P1lFNlkCBn9t3bUO4bnVuaeeHP6XEiWDz22B+HEdqyKREHriSamrcrO4Mlfkca+D33
	 n6hWHs98+789j93ND3FgvkuZfiJtAAY8LFSeIZqt6wui/wwAIp8AG5Ps5ZF/Ltr3km
	 HBdiZMOkH7Amg==
Date: Tue, 27 Oct 2026 16:13:29 +0000
To: netdev-bot+sashiko@kernel.org
From: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, aleksandr.loktionov@intel.com, chwee.lin.choong@intel.com, faizal.abdul.rahim@linux.intel.com, horms@kernel.org, vinicius.gomes@intel.com, sasha.neftin@intel.com, matthew.vick@intel.com, aduyck@mirantis.com
Subject: Re: [PATCH net 1/3] igc: pad preemptible packets before reserving TX timestamps
Message-ID: <A-quLtOuGUuzG62X2MBCsGRnqwsSRJWaFG20X4lGiqSibD0d8k6Sb9sJzSzWWmNfpifuBH1NP-3XQosT8qRxL6HsdS-bLkKDsM5qa-xKvHQ=@1g4.org>
In-Reply-To: <179310342759.3134.9480442291648763504@kernel.org>
References: <20261026091549.605810-1-p@1g4.org> <179310342759.3134.9480442291648763504@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 5b15948b41f786a87601500785a121bdfe9fdade
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> [Severity: Low]
> Does this description match the tree this patch applies to?

It needs to be clear that it is affected by that commit.

> [Severity: High]
> With this patch applied on its own, igc_request_tx_tstamp() still runs
> before igc_tso() and igc_tx_csum(). Can the same shared skb problem come
> up here?
>=20
> When a GSO skb with a cloned header (for example with a packet tap or tc
> mirred active) is hardware timestamped:
>=20
> igc_xmit_frame_ring()
>   igc_request_tx_tstamp()
>     tstamp->skb =3D skb_get(skb);
>   igc_tso()
>     skb_cow_head(skb, 0)
>       __skb_cow()
>         pskb_expand_head()
>           BUG_ON(skb_shared(skb));
>=20
> igc_tx_csum() can reach pskb_expand_head() the same way, through
> skb_checksum_help()->skb_ensure_writable(), on a cloned skb.
>=20
> The next patch in this series, "igc: prepare TSO and checksum offloads
> before TX timestamps", moves igc_tso() and igc_tx_csum() ahead of the
> timestamp reservation. That fixes this by the end of the series. Should
> the two patches be backported together, since this one alone leaves the
> TSO and checksum paths exposed?
>=20

Yes, I maybe need to research how to properly denote this
