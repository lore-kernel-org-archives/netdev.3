Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793260199;
	b=Pz5l5vdApHT99kxtjLrHa3oUHxuLQFAvEf9vl7VbS2JdFa6fv6P6LgwpUzZPYPGAN/Sp
	 bv2GoH98bmQUWpQsHH/Xhzt1rdXhBNUGdJnUdyMGCahrYOCc0Q2a2TsQRcxuGcj7qs2FH
	 anoOGdHgvaoe/yCHg6RFQNZiIyhJczevk8LpzbSBe81bumrZ2oL5AA1dtZ0iEAFSx4pkK
	 P/P6wYrE4zERr5HOvwk5iMwcUXpYaXtcbP+TDpzJjRxJkV/ZiC3PQzFaEWEdoRWxk3Su5
	 4nSNr0kmu91mUrpsHlJadzeC/kdXkMHPDX7DzHqGyhJm6EGj0uPPUBt7Fn/CfeXbH1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0Kx5T2Zh6GBBFVRGRo+yPdOYmemlYMbdnEqHarr3OXY=;
	b=jgDQMP7geG3DxkCwlmxWYyya0YS9pkk4F0BfuZDNRFVvGbSDOJSnQEkllGiXicHe+9+2
	 2Sm9cS9YOo+8i0QnXwrf8rbFW+m7uGvsSLNR1beh5mA8Jwc0JLl2z6uf2q9n/8gEFyuUA
	 aMhpQq1a/SH4Tbfj9Azuib7uBjZ8Ak6tWgsB/926p+5a3H6Ax0jSE578mixVxtGwcMUmh
	 +kAvoO4XGnJDoVWRnzQHBpyuE6ovRJ0gvwTapY2uF5LLlJIq3TQhtFxM4cTNLurYS7rhQ
	 PIpNUJIHSpg/FGf5CQNJU4moczyfV0YWzcgeIkr9NnzAtK94gL8/66urP07kuCrZqDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tE8cC9v+;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5911E606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 07:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5911E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tE8cC9v+
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-369f33df08eso3428116eec.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 00:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793260198; x=1793864998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Kx5T2Zh6GBBFVRGRo+yPdOYmemlYMbdnEqHarr3OXY=;
        b=tE8cC9v+vwT/2Loi4Wz9xzCZ/GZBX/8g+egr8DRZjNynMG2QjspTrw14jfWHyvtWtB
         Qzo2kPj6EpVvC7wf26zBh2iN3aOWlXsn8FLdoyyOeh7r6qK1kH6QBz0BFmQy7BgkP7Am
         bmLvfhKy2lJKjOwm42w6k5LKBB3CKSHnqvdjV30I+cFmds6wk7MzK517GuH+XV1FDNwT
         gDX5tfpP2/rG+DcDXStCz5PcWho2PXzXBwFWbSN4995fw7a7ewLP7R+MAnFbxvWP8Wec
         vLeDqPPHRhX+qvRRxFHhLN8I5+dTfU5L4We1xf1gj41s1Rm7dhQ7KuBMvQH26gm/njkz
         arZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793260198; x=1793864998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Kx5T2Zh6GBBFVRGRo+yPdOYmemlYMbdnEqHarr3OXY=;
        b=oWhav7rnO2J14oky/8OiftUiuGl0qjNMJO3qps3yX3tXfdjiztvVD/eks42weD9u30
         3dhbAUmDM3aH/0TYBfsAI5SVBsYShDDDMPzYDnOZgNCEqWYqQ3NKs1rT7VvPrWrsUlKe
         hyT8cRnvMR4V1h4ZSlQysFXPLA4U9KgsuPB4MdWVFbl/Z15WhzaaO5hxE/dv9GcKiKhA
         TSOQqwX6ZEI9X9cvJGgyWsiJqIDb7j73PhC4clPD/cIzocusewSus2KnBVy403r2pV2u
         NX2y6vxMYR+wIND2wco1mE5STfRrSzGN4ydvLvNldlUItbhwjj8rrfTNaO+kfIbDZwAE
         mhmg==
X-Gm-Message-State: AFq9FYIk2WOEPMXVJRILCm2UkGhLIxa3LXXobZmHb2DYP0vAC2mfWqx+
	2iIwH7YGDkkQGB3sV0r0grlunUqDA17qt0RhAa7uXzQpfrBdq9aI8I29
X-Gm-Gg: AYBFou1b90jzrx7E5s+OHSJoMS3W3pnLzaHNBHJLZRQ3Ntjjf3KvKY/GGwrepViumIH
	DqDu+Jg3o6AQoEQj5w9g9ejfrNf3wPYCCGBslwI+zCJjpgsNKLmEYz66hge+OFOPGtw8MbwlUaT
	poIaJ99e70ysghgKWSG9uIS5Zw1TQ90SF7921mV6mTCuZDrTEITezlOOud1gxtzrLc+oyu/PtEu
	DseHOW9zK26lGvA0MfCymkO15U9VrlhMQxHE7j22EOFPGMqoPfDoms9H4m6yHzVR67kKx7Bg1wT
	mxhMX1sfeY9S0jBVYMrAHUdZ+/ioZhXeb8xKID0NhAO+QTvzaODGYLFg4w5Y6RHRmw091sncE1d
	L2lMmvjnohECDVvi1sfVlozoc/DD7mk52Bu+bJEU/0am0dIcepbGlVK1e0ddqcMWrHzgR2doZQu
	G0wb+qBx1/D45x5zmUnckbz7CRU7jOqjJNP28m988hlsRX62PYvMEunBGSFBGuFcdTw/2sxFvTJ
	JE2hqhFDGGpEDZbSP95RbrqEw8w3nFkKoHEnGXGQLjGZ5fjr6LP+XiIxWuexSzj/CgFVxcVo3Gh
	u/1COcxxDnfcF4HNCRwbHpgSTU7GzE6lENt58k8K7bXsS6Mb75aZv+r5gzU8WF2yLoLN2hyIo9U
	vzknGqQULEPwAkOKL8nvWCPD30UNIY43tUIKeEwRGWvde3+kT13IDQz79S2v1cfiA32G5MU68QA
	==
X-Received: by 2002:a05:701b:2304:b0:1a8:b566:80c2 with SMTP id a92af1059eb24-1a8b5668212mr3515852c88.17.1793260198198;
        Thu, 29 Oct 2026 00:49:58 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75d4887easm12843583c88.9.2026.10.29.00.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 00:49:57 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	XingWang Xiang <v3rdant.xiang@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] genetlink: Reject joining multicast groups no family owns
Date: Thu, 29 Oct 2026 07:49:51 +0000
Message-Id: <20261029074951.3413609-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261029062214.3407223-1-anilkaushikwireless@gmail.com>
References: <20261029062214.3407223-1-anilkaushikwireless@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding Jacob and Jiri, I missed them on Cc.

On Thu, Oct 29, 2026, Anil Kaushik wrote:
> genl_bind() checks the GENL_MCAST_CAP_* flags of a group only when a
> family owns it. For a group ID that no family owns, it returns 0, so any
> user can join it.
