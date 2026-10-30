Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.111.35.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793335355;
	b=tetaP8yDu0cFn66xqQ2WObmaOMaMSc1gxrjB8h7kewiPmNbI/yL9tvaC7RIDv6AMpVGi
	 qAv+KfA4/zttIRnfnNFVQRk7yF3z4tm4WHhiD3zaJzMtLcwFAQFs7F21b/mMa16ddrdsu
	 ZnOC/ZmsxVH9l+bgwqNUdOZmsNcBWOrDbg7PKfNbAkf+VDBbcDKkHBOr6Br0fwnApaZBv
	 TGLrBk7j6cMq/PnziamWNaX3udNdsVpFZKUJvICKJe1CkDfrup07zJFy7jtfrz2+VuRjz
	 0Stjwd7W38qbVtS4EpbPd1QrldftjMj4HWoxTmzB5dd5wAWIu8P3xWbH52t4Mtc2y2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793335355;
	h=DMARC-Filter:X-Originating-IP:Received:DKIM-Signature:X-Session-ID:
	 X-Originating-IP:X-Works-Send-Opt:X-Works-Smtp-Source:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wDxxms1bv5/o+/3MhiBxEI7oF1cgDh8buYrPsh2YVoU=;
	b=cqRKHb1ZF+Nh8+qaJvXIeedwxGkklfNagh/RVQiO/ehyqJVma3jm4VkDwYjUnaN8nic+
	 kr93fxnpowGcEVFuqQgoSQ19gB7OVJo90PeWCNUDUdRAc0C7IM8LBYjMdyThM1FjE+4Jk
	 E91QCU7v6Hk3+bLNSIk8E92PYDRr/jOk8XQEZ9Caqh5KSpWTw9AVFO266aXJDphmt6clO
	 3Cgg9rv0czraKPskQhz5LJfs8taWstDJmHc9WH4ZYCU9nTqlsQiCfcfGHexueO6/iz4C9
	 fHZ7c8419HJroXLKZLfyh68bc6JRqto28L5d7RvP1bFRJeccHzRjOBde1EqVKWXg2qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=navercorp.com;
	spf=pass smtp.mailfrom=navercorp.com;
	dkim=pass header.d=navercorp.com header.i=@navercorp.com header.a=rsa-sha256 header.s=s20171120 header.b=KRQO+C68;
	arc=none smtp.remote-ip=114.111.35.180
Received: from cvsmtppost03.nmdf.navercorp.com (cvsmtppost03.nmdf.navercorp.com [114.111.35.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E252606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E252606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=navercorp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=navercorp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=navercorp.com header.i=@navercorp.com header.a=rsa-sha256 header.s=s20171120 header.b=KRQO+C68
Received: from kr0s-hmac-real-0 ([10.180.30.112])
  by cvsmtppost03.nmdf.navercorp.com with ESMTP id gui14rWkQieoWJFeWJCH+g
  for <netdev@vger.kernel.org>;
  Fri, 30 Oct 2026 04:42:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=navercorp.com;
	s=s20171120; t=1793335351;
	bh=wDxxms1bv5/o+/3MhiBxEI7oF1cgDh8buYrPsh2YVoU=;
	h=From:To:Subject:Date:Message-Id:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=KRQO+C68DxEvsSwOBlPZTsXCevr+YLfwKFYtnJiVBxPcsWHuJfn1FTyhBfT0DHvSp
	 VvOdOIwafcIv80cdjxKN3NaaQ0843MJ5kpWIYqQZyvPcLzhA+Mbn8hH9CuDo/2zv+5
	 vcVNKkhEU/VkhYWxb/Vz2YOlR/Tbj4qrP2Cb4Jyd4KLFHlch51xaxMJn0BOGxQqtWV
	 hh/wxA4UmM4TqLt9xxnfMbPdNYwKIK31oWQbHzprk5Ya2OhO/mmXq8fwlLTKDrxIMX
	 z7E0CVVMVDx8jA9qi50/2WdBMvOcIdLeJBL53vP2J7sorPWIg/a5Z+3+0e7Xc7Uydq
	 p/NI6BswNgXLw==
X-Session-ID: axEJGcA2Qpem4vHPMyrmQA
X-Works-Send-Opt: TdYwjAumKAumKAbZjAgmKqKXKoJYFHmwKBwYjHmm
X-Works-Smtp-Source: XqKmKqKlFqJZ+HmmFxvZ+6E=
Received: from localhost.localdomain ([10.25.101.111])
  by cvnsmtp02.nmdf.navercorp.com with ESMTP id axEJGcA2Qpem4vHPMyrmQA
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_CHACHA20_POLY1305_SHA256);
  Fri, 30 Oct 2026 04:42:30 -0000
From: Gyutae Bae <gyutae.opensource@navercorp.com>
To: Paolo Abeni <pabeni@redhat.com>,
	stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Minsu Jeon <minsu.jeon@navercorp.com>,
	Jonghyeon Kim <jong-hyeon.kim@navercorp.com>,
	Siwan Kim <siwan.kim@navercorp.com>,
	Gyutae Bae <gyutae.bae@navercorp.com>
Subject: Re: Backport request: Revert "softirq: Let ksoftirqd do its job" (d15121be7485)
Date: Fri, 30 Oct 2026 13:42:28 +0900
Message-Id: <20261030044228.7815-1-gyutae.opensource@navercorp.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <9024faed-854d-411d-96c1-7cefd4d68dc6@redhat.com>
References: <20261029054200.97234-1-gyutae.opensource@navercorp.com> <9024faed-854d-411d-96c1-7cefd4d68dc6@redhat.com>
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

On 10/29/26 09:33, Paolo Abeni wrote:
> IMHO such change should not land to stable lightly. It's a behavioural
> change with subtle side effects. The threaded napi feature is disabled
> by default for the same reason. Also the revert has some soft functional
> dependencies in napi threaded cleanup and improvements landed into v6.4,
> i.e. 6bb218b5a6e3f3c5e2e76faf8fc976f3f6f72496, likely more.

Thanks for taking a look. I understand the concern about changing
behavior in stable kernels.

Gyutae Bae
