Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30B4FD789
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896435; cv=none; b=I954W5YJAyih0SNM58OWARRfva+326VEtUo6dMa17VvYSLPETL6MQ0CIr/1PLceyQqeVNs+aEtxjGxbn58yGSDCZDskJYcItcYbHeAjeY6Lx8BJFF5rkjLDucN++zG88393YF8aAbn0KXhBhc7sDQahWRBNjOhqWBAon9s54XVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896435; c=relaxed/simple;
	bh=7im7GL/ZuwtN87J645EONyNtIwr363HuDNTFxRo4AJc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UO9wnrevp0VjPRwAUT+6Fbs7OLZCIxrIaR5t9p4DrXbxu7BKHlTPQwsvtGH7QOXbiMBNKPfREaRmoxlvXfqyB4pMtt9KnKXg/d6ityI0ro59uVpyoPlQ0uOPmi9puyO7ilUcbXtRyhOi/9w1P+WbwQg/0ZJoEPRorqI6bpZpwaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sorah.jp; spf=pass smtp.mailfrom=sorah.jp; dkim=pass (2048-bit key) header.d=sorah.jp header.i=@sorah.jp header.b=YikTtiTO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ir0qH2Z5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sorah.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sorah.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sorah.jp header.i=@sorah.jp header.b="YikTtiTO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ir0qH2Z5"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 8DFE6EC0529
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:00:33 -0400 (EDT)
Received: from phl-imap-06 ([10.202.2.83])
  by phl-compute-03.internal (MEProxy); Tue, 13 Oct 2026 09:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sorah.jp; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1791896433;
	 x=1791982833; bh=7im7GL/ZuwtN87J645EONyNtIwr363HuDNTFxRo4AJc=; b=
	YikTtiTOlomhwPlifj+n7hB+iPybhdqYGV4LXi7wOnnNE/7zTuQ00/ZysHlQX1jV
	IGmriYqmKCY/XCUZJC+/EUdOEJVB9bC6AphUGmZ4JyqrgtswLQ8hjHy3x04skZoj
	jdhDicurMouZ5QuFz+VnGUjgu1HSMSQa7e7yRtnqeC3GfcbrFQTIfiwwBq2veu42
	OpS9PPd0rmiXAPQ6hwFWOumMZz7PXEgn1qJuIk0uuCKOvJ2XAdrFQ9AbE7EWHl97
	Zqc31Fm1A9fwgIsp2nJeanvs/JkR2ZYIYlR9O7SzekfZiJtjSt8UqCT99gzdV/Xu
	Hqe4edgBtwNbS6RUKWz/gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791896433; x=
	1791982833; bh=7im7GL/ZuwtN87J645EONyNtIwr363HuDNTFxRo4AJc=; b=I
	r0qH2Z5ezbbIDDbIU1axYfsaJc6eIDcL+ySSfyTypWKWMGxRJ3q5nDOoT9kqKTHO
	AATVBTu6btx0F8jvwXWo06AP/wqm0mC7vVZnJQ58RgLq9+Du0+xkiNuk+yPMUnjo
	S8rWD4/uPy3+IYjyuuPWOKzB+acrhWUy1er1bW/fpgxxC/rQKNtnCNjaPgSsXvlv
	7vqfzBQCneQUB2sJUxtPUixQwg3CYavkP8N19XsOUy48xqz4VBXFny+Qjyf4Ztpv
	qZkW6WJZli5Yn19eJhIEOv0T4y1ENVcGRjGBu2AVI8bbmz2n7P+DNJ6JJ7aEL1b5
	H3ujtaXKDS9nrSi7BKsiw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=sorah.jp a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791896433; d=sorah.jp;
	mf=PGhlckBzb3JhaC5qcD4=; rt=PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:SL6zygJ29yXcWSnEUk2oJlPwHSFPXznCj0cg+Yr0uxMfybo
	w0csGXkeKbk/PPKY1c6yKdcTSx5fTG9NCZ6XOvaWYTJp/Gpm3q+/+N81iFOGFq3A
	ETYPylCucpdlR75eknC7h6kRT2A02mA5wc9GzKsOzKZGPx87UOMpKYpz1LWgTFaG
	4Z9HVYio0+oqPbNcIM1dCttZH/ImRpSrQTZTDPNbVtZcCdUDFqGVhHAravHM5V8f
	dq/Qu/nnSVZQ0c7wVaHxA5JRhTqIhQM34LZTil7rMevV8xE+1peuISUyLAL081nJ
	zc1ye2EkX9SWARcPyeFWBs9F7wXWjKgEZisRjZg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LdqfKRARqjrBC/drbbphWpVwD4eI14jOal3Emb3AOHY=:7im7GL/ZuwtN87J645EONyNtIwr363HuDNTFxRo4AJc=;
X-ME-Sender: <xms:cSvOapay0GSvqIL8FQqkytNCi__41XQLStcQd6fVsaHHhnoGno22fQ>
    <xme:cSvOarOhJf-kEIA9Lrx03Uwgsfuk4kN-VLFlkBY-jv7RD56aheK27R842YSgLBJd1
    axTqm3dkQEnmUCdIkR1RrJSFcPkEMpzH1ZuGufb-TEu4468f1mDkUuT>
X-ME-Proxy-Cause: dmFkZTGSCXnbkU/HlcSBjM1SuyLFeN+/tBDJ1iapM8v6UdkCCaXm15kd62CM8Mv59B6wXZ
    7PxwBMqQKZ7Srme/q3YRzlx1hpBxJuOUV89JNyG+u2Gvz5yprMQR4B5bowBC+hg6qTuBfi
    cyga2MWJxmfLOEk5V0KBCFCMxoRySmqzC0/mY8G4rDUJxTnIXdMIn3b+JtuEafIsPIfWhf
    lsAl/k/6CaF0fqgY62gbVuyTh5DUi7xTIBHH26+nOt38LxEq4EDeZlJIiIifXuYmSiONsJ
    EzPlQSO/YvIKMmqLUtzIYB0sQIg09nh3FcjdcJ6yCwpxXEMDWg3OBTRPYA4kznWRzpP8dP
    iexvKDWWgC1YjgYfk5ruXkg6hjmua6FRrW+i+g/y+Tqdz/AXyUf9PD1fGjLB8sul7cuhqY
    J3+RSRYBlL8RZnqY7cLGSnyDVzd+maxtTV35U8oZ0Xk/xZz8oXdILdY3gG7bU9Ft267Khd
    VoLfP3B9KLC3VAV2cWQt02WSEYUD9ufsDAg8DCbv1rZwsT9fhwl0P5lXpsf7yGLI8/aqLq
    kg0lR6lQKYtV3lff7hLhK2LqIFRq0aMG2d6dtthNbhuhP1Rmup7e+J02jWfEq7VsIZdU6w
    r0RhIt13fLzPwt6XZIcR1IadPgADAjm/+n6LHV1koD4fEkMlHa1A9dt4ZlXw
X-ME-Proxy: <xmx:cSvOai8yVLyT6O4_LPZLNeKxpsUotgVaceCgqPk9eXf0LemZfIjCGA>
    <xmx:cSvOaulqKNFfZrjv7hnGTUrY8MhfKJcm53QRrAVrCOhdtYTq3fs3OQ>
    <xmx:cSvOalD22cplVjEy99e7UhMc5HAtjf8gTT8P1bZo1JRbAMmrRGkpbg>
    <xmx:cSvOavUqC2EA1wpIN3G1p1MrVVXzZI37g1A5jQ4dRGz8tLp5TY6bvA>
    <xmx:cSvOahPAuMKsPkzSjw9Fujs9TIMhpmv02I-Uny-3intVikE5xhJqUiIx>
Feedback-ID: i0449494e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EB861240009B; Tue, 13 Oct 2026 09:00:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AoXn1KR5sOKB
Date: Tue, 13 Oct 2026 22:00:12 +0900
From: "Sorah Fukumori" <her@sorah.jp>
To: "Eric Dumazet" <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 lixiaoyan@google.com, linux-kernel@vger.kernel.org
Message-Id: <20f75d91-97fd-479d-b3f1-66eaaf493261@app.fastmail.com>
In-Reply-To: 
 <CAL4WiirpDVzho606z1gt5=1=MFykgTC2CbqdAkxnngSvBYq_Qg@mail.gmail.com>
References: <20261013102453.3272620-1-her@sorah.jp>
 <CAL4WiirpDVzho606z1gt5=1=MFykgTC2CbqdAkxnngSvBYq_Qg@mail.gmail.com>
Subject: Re: [PATCH] net: gro: don't chain linear parts larger than gso_size into
 frag_list
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 13 Oct 2026, at 8:03 PM, Eric Dumazet wrote:
> It seems an XDP program with frags support in generic mode could
> get there: skb_pp_cow_data() builds a head_frag skb with up to
> about one page of linear data, the rest in page frags, and
> skb_copy_header() keeps the GSO metadata. Two such 64KB packets
> can not share a single frags[] array.
>
> Have you tried this variant with your reproducer ?

Thanks, I haven't. I tried to reproduce that variant under various gro_max_size/RPS configuration, but I couldn't repro on my qemu+veth based script.

Will send out v2 with updated commit message soon, and sorry about missing `net` prefix in the subject, it will be included in v2.
