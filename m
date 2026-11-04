Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755457;
	b=WQI2HBP5Df23ooWJ0NeucKpVlPUu0Ea8ll+tN7qaRgV6TbjUaBQE6cIeSOC7vYyntN96
	 NL6+CqKiFYdHHsAd2ctt/tvEo2/eGWcVRny9JCtjb1W65/XJ/SnRAneQc33MZz2NtU8gK
	 Y0ANSjEPyST5O3hXc1Y2mBdBHe1m+5vnLRUcEA/pUCPb1Vjm4yDhL6bgNZHfAeZoX10f/
	 0biX4U6609ebw4TB6Qa+/ySvlBywq/LaOJ5bjZVeAAqUyf0F4EJHtgq/NjXpiEkZqNqf4
	 Sxpic+LOW5ltXMBZYzH40EaqSmblwujaeOiHEMILjIKEcJVLJXy+t6lN1mJJMyurTzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=XU8v5l3j1NJaqJxqv+9h3ZaBWo1SvrTb91gs/U4dLXE=;
	b=TtYi9jlKaWocAu4zfjsRFM7tmoSAAtwYXrSQ0Lu/0PGNL+wtgkYDftSQXLldhnsG8S5g
	 tXEMrzwH/byNiu52ebsDAtRJh9Hom1ysN18tB+MTjG8lpt110Vks9xFsLwkv6NfesulPJ
	 jvbvQ+PmTLuyQxII9xfK4jmTNe1+wE6fDkzxzabI40X7Y0P2fXt2ozAg/e1Nb+b/1Gwpl
	 aSbrU8g257xN8ureSd0fSgADxID3KrPpWlbx+Qf7kNsofVTnVictppAh7vJQK8WHLR+ae
	 UKzHEF1vRJb/viGOAa2dGuA307WUqfEy66PAY3oN6/Wa5yvU8HG9eW2vGQCiNfs9P3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=waAzsuNI;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C108B606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 01:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C108B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=waAzsuNI
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36cedf1bd63so45523eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 17:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755456; x=1794360256; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XU8v5l3j1NJaqJxqv+9h3ZaBWo1SvrTb91gs/U4dLXE=;
        b=waAzsuNIow2jqOdqdB7euB21RrbldHH85o2R1JoeadLJjWkhIdBgr2T3S0zCyYh4q9
         a+WKgiuJavwofUwI0WvHi9B+q8oLHpL1XmYsJFxXUrwbKC2emI46itAKD5wma1Rf+rbQ
         dYNjrUvjb8y4UIdUuxn3q8B4cfoNAnonCAZgPG7FJ8Bk26biQcSKNQ7lQt9V1JoyZpNU
         +OJHQYhnh0ORNvGca7doJCPdddBk9WZqdEYyvgF5rXHU/MAuJaBDUi6lTczXlek/bxHO
         AS3LboUF73MSBysnsrrSkZ6FjSvCevLi8ODTOuAwTh3lyNAJqegbzBCFv/aE81Y3Zau9
         vgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755456; x=1794360256;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XU8v5l3j1NJaqJxqv+9h3ZaBWo1SvrTb91gs/U4dLXE=;
        b=TwjksYxWs1GnV8MFc0eb77mXAnAQo3zbAd4ixmw8JsMTx/jzMDEVyrvmGlf7IcTPQl
         GsNq0M2c4vfPrGFexQm/YrK5yZZr6oF2arxtr4sVl9Q+ZR7ZNeJ3ks6BBMm5SFYMMcbZ
         +Q3DjLoMkq35YDij7mmC8RpSxvAa9UU4a2Oz3NjlFHlHcfze/HJJGDDUhjggBMG+PxJq
         qxTGzqExZGd42ztC0AoL/g0MOLaPB7uGsN9ATBO9b2cikXClLM0ZR0vDYhJQJbOAsnLb
         +llApEB9+clB1cuihYo87rMQQRcBTHDX40AxiJTGwbM8M1GhgtRcO1dghKBK0ecsdnE1
         y8RA==
X-Forwarded-Encrypted: i=1; AKwUvBwqn/YnNj3Un+3Oup7k6j4mKW16Xk+XCdYCfHtyWeZ16+XAzyrrzEGmukYw9cHKPTth6udhkSM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5DjKrVPT0HXoazR4E4kkYs3CvBaJBL0HM+r92TVPk1hC7wJnH
	RHb2WAeu/wbdQRdMFQPMGN/PjkDPxjGPWE/Vh5Np6Mt5qsaESbMG/nhg
X-Gm-Gg: AYBFou20ME3nU/vV0hVorMIXvA++eY+aY/4JllPNlwhHZdYsjFblE08JhFz4ABzNuuo
	Chv16o2uhx060CzXouyjzsXg6uych3pZa5QnAZwYzYDHVx65viF8Mn5pjcnZXilEgebWErXFVCr
	8m3XsFp7be9Uf7HkPKhcr3KrNBq5Oln0U5Uo8WN5hMNgWYHf+tHXF9TllKtCiDY9YvvRkcsz0Jz
	WZr7e4oqhoSo6DefRkbJLj5B016ruSfk3jPP2GCQpPGgnpcn+jDfYc0jUoS5q4GuJH4I1qzGaXa
	sjetoxLvc2eVTyhszlIwVwGbdkwiza25NQMKGrjyvYOdNARgmeTQc0UfFG91jxuaE+yh/N4tEXD
	TFBGHkl4bMcj/t3QqDaGl9xRYtgqCGq6bxpURqT8BHebOjlfhzjIdnZ1+wCKJqShz9e15Y4eDSn
	qAwWRDN6wHYL4BpQRoSmhUTu4S5BrjJ7ivD4gpI2d+eaboWqtfqbucQX1lthHT6PnEXdkzGz6oL
	XhxIvZQs/9frdVauLdKpqJejhD45gm/s56wc0RatNOGyYko0ZbqC42EIQsSPoQjfbHqVXJFhx5a
	ilycnilAcBw5OmyH5Ivx0dGzIiaioSwnK2meQ53m7XQUSDU=
X-Received: by 2002:a05:693c:41ce:20b0:359:27e6:b684 with SMTP id 5a478bee46e88-36a2fd486a2mr25765748eec.3.1793755455764;
        Tue, 03 Nov 2026 17:24:15 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38a54ccsm2373254eec.4.2026.11.03.17.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:24:14 -0800 (PST)
Date: Wed, 4 Nov 2026 10:24:10 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
	sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v5 2/2] net: restore refcount ordering for lockless
 socket access
Message-ID: <auqJOj7RVCWn7Ucl@v4bel>
References: <20261029214219.1035176-1-imv4bel@gmail.com>
 <20261029214219.1035176-3-imv4bel@gmail.com>
 <CAL4WiioDoAT-50wStYDOy0b7f972QivB=Zk_7TCDrVPfOY665A@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL4WiioDoAT-50wStYDOy0b7f972QivB=Zk_7TCDrVPfOY665A@mail.gmail.com>

On Tue, Nov 03, 2026 at 03:49:40PM +0100, Eric Dumazet wrote:
> Le jeu. 29 oct. 2026 à 22:42, Hyunwoo Kim <imv4bel@gmail.com> a écrit :
> >
> > Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
> > of refcount_t"), default builds implemented refcount_inc_not_zero() using
> > atomic_add_unless(), which provided full memory ordering on success. The
> > commit removed that ordering on weakly ordered architectures, allowing
> > accesses after a successful reference acquisition to be reordered before
> > it.
> >
> > Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
> > lookups and in inet_twsk_purge(), where the socket is validated again
> > after taking a reference.
> >
> > bpf_sk_assign() can receive a socket pointer obtained through BTF
> > without a reference. Use acquire ordering when it takes its own reference
> > for a refcounted socket.
> >
> > Use refcount_set_release() when setting refcounts in the SYN cookie,
> > TCP Fast Open, request migration, and TIME_WAIT paths. Keep the existing
> > TIME_WAIT smp_wmb(), which separately orders the refcount store before
> > ehash publication.
> >
> > Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
> > Fixes: 27e5203bd9c5 ("bpf: Change bpf_sk_assign to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> 
> Lack of links to prior versions is rather annoying.

Is the cover letter alone insufficient?

Should the changelog be in each patch?
