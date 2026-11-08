Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794134429;
	b=x7t3ZJr2d+F+1VIkW8enLQgrLb2OWCT0t1A9QFHpBiI3SniT+wk7i5oDHkoLKfeS362Q
	 NS8Z1ZMvrnmGNEJ6fce1s+nnBcbE1erLe8btwAr4nm96IxxKTFAlv6oz5sh5IO7ecQtIv
	 /blRXA1UGBvaTLxohkAtH7q6/Zls2sBJbZjOhhCJlS+woA28XxOyPips3jHrnTfm8Qqy/
	 sytLGBSRvr0nM2RAMMvlAYIXgR4AD+bsL3eNgRLWhIBPeKL7xR+mSz72murMrDKnAefgu
	 /FEXGkjEBgLr0I77PFcIgXI27C+CDEhHuclbs8sUGsoHAeLa/emwSIkPMEvOfSpr/uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794134429;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=ovWprSQOuXD+4mcX3DSPO+n0usba5lmjW91zjF05Tps=;
	b=yzx4KtOcicVjugdOm+EBQ4xGomvwuoz5q7fhF263AY4V/J163B0FXsFtaRPDvyK+ZhFp
	 tdPaZ2JzyvCT6aBZj+ml9mlJ+sLSlAsONQkRdPLHckwW8WV95EEj8aih3EOM8BucY6cPd
	 ENUGLhBzSWIfbwpOtT3+S2/gKaqzV0IeGEplm2O27PsMwJ7qVdYcQscNgTOPFRxb3mzMZ
	 FlIbCWlfZopP5aLiLpXDhZYrJriOn+kMd+jXwc0VVr6qA83IJVGBBMBxmd4fVXpTE5Ukn
	 QTEjbVxGD4AjiDrE6m52CWXm9BSSxZLopFwROTr7V/4gdBqBM3MyLBUIjry0HtX68kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8F1606A332;
	Sun,  8 Nov 2026 10:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB8F1606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB31bqRUfBqgqeZAA--.18597S2;
	Sun, 08 Nov 2026 18:40:17 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Greg KH <greg@kroah.com>
Cc: Alex Elder <elder@ieee.org>,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 elder@kernel.org,
 kuba@kernel.org,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 pabeni@redhat.com,
 vulab@iscas.ac.cn
Subject: Re: [PATCH] net: ipa: Fix valid_state leak in ipa_smp2p_init()
Date: Sun, 08 Nov 2026 10:29:00 +0000
Message-ID: <20261108102900.3182133-1-vulab@iscas.ac.cn>
In-Reply-To: <2026091702-engraving-bride-3af1@gregkh>
References: <20260917115424.2149947-1-vulab@iscas.ac.cn>
 <2026091702-engraving-bride-3af1@gregkh>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAB31bqRUfBqgqeZAA--.18597S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1rur13tF18KFyfuw45ZFb_yoW8XFWfpF
	Wftas0k39xJ3WSkw1Iqay0qa4ru393Gay5GasxK34Fvr98WrWxtryftrWqva43u3yfWFW7
	tF43tF15CF4DA37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxV
	W8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjU-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIFA2rv4kisHAAAsC

Hi Greg, Alex,

Sorry for the very late reply to both of you, and for the extra work this
caused.

Alex, you are right that 96ca1e658ae45 ("net: ipa: fix SMEM state handle
leaks in SMP2P init") already covers this.  It releases both SMEM state
handles on the init error paths and in ipa_smp2p_exit(), and it has been
in mainline since v7.2-rc2.  My patch duplicates it, was incomplete on
its own, and was generated from an old snapshot (v7.1-rc4 based), which
is why its context does not match v7.2.  There is nothing left to fix, so
please disregard it; the patchwork entry already shows as not applicable.

Greg, I owe you an answer on the Assisted-by tag, and I am sorry for
leaving it hanging.  The candidate came from our static analysis tooling,
and DeepSeek and GPT-6.1 Sol were used to audit the finding and help
write the change; I reviewed the result and I am responsible for what I
sent.  I should have declared that in the changelog itself, and I did
not.  I have re-read Documentation/process/generated-content.rst on this
and will state the tools used in the changelog text from now on.

Since all three changes here are already upstream, there is no v2 to
send.  On the volume: you are right, I sent far more patches than I could
follow up on, and the review time that cost is on me.  This has been an
important lesson.  I am now going through all of the outstanding feedback
on every patch I sent, by hand, thread by thread, and I will answer each
one.  I will not post patches in batches larger than I can personally
review and follow up on.

Thanks,
Wentao

