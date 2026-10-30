Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334170;
	b=tlnK4KitOsJWF3xyZZUnvl8q6CjL/NKFMluIvmSdHHplZ9zCZBPfvuHgKbbAHVcal2lN
	 eeBdxdE0BPSKgOF/zPEY1jAAz9nJQWCOSuqHkq95FI1c9P7liRt5Hrf6Va76NYoK9oJ5X
	 i42HWhTLRKdz4S1EZwKbCZPEX3r8nNkU/ViPoaN11A54zvkUS+DiTCyxMJyBknvoJJtBu
	 JRX8sZApsqqdaNRYswOVmxNpIizaOF7yv7xnbfXuoI9FCkGU62u4PRLbxrNnHiKPW0XXj
	 i3DkspW1tBfjEAzxcDMYy57g9gXD5I2k/2bRPVzCbdsBdXFARk5OBToF35SEiWid99Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LKdcLwwbAs+9mk+2eST/kXpD7oMhNL5RH1/U+V8JfPQ=;
	b=TRU7Lx7iF1Y2WL17NxZf+SPwZaTpO8WfxuK8QYaZkwh+d621z98GcYsl8rR3b96x8F+N
	 Qc5eTBRyvMq5QWJ0xksmonX1xyre8VzmaL2HH1dSLDn7vn/spOtIR3Sf1VLdeYIDv7hP8
	 j/HWJ0DFWXo+ZEqwXc8xF/oFZAa6cXp7EPZ03mnKvw0md890QG04u93x8c8t0kw1wjqoC
	 cIbXS9BFVomaGVkRjmrGSz7zPNreqNj3iQecx2EgH+aYilSQ2YYCSCixOIVec8x1oXp7Y
	 y4iba893NyF4BON0WU/k9LeFAg0XnIzFd1F2D6dT+IMbIY7atARxQcHJSG+nLbKV7yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="HH/5x1Hr";
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52092606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52092606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HH/5x1Hr
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so175345b3a.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20260707.gappssmtp.com; s=20260707; t=1793334168; x=1793938968; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LKdcLwwbAs+9mk+2eST/kXpD7oMhNL5RH1/U+V8JfPQ=;
        b=HH/5x1HrhcH5qVKNTrWXKdrNUXRlbO8WZvlnJiQZ6Fx0rvohU6rYUrSJQkzGO6QeUc
         7fTNITiDKdO6icU/O019rN3nR/4MwvcPRi+PFz/hLc7tPy3FPmr/N23LooSsgiIPV1FS
         RiSV+mXx4WI7ZYM9zpAdHibonCcG+QpGZbI6joPG7n/jY5vjGdBmLMUtA3ASztU3hicw
         rFn3eyRjafNMpvhdCW4SssnA2zRnKKA76+ze+Xm5QvmKK2bFL0zshmi7UmTVPyS+We6q
         FFMasastOJvC4EHLydNMSzaQk1WppOWzQU6Z/wncxO53NsjrXQ/gNO44L1oOGl9IEKza
         V1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334168; x=1793938968;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LKdcLwwbAs+9mk+2eST/kXpD7oMhNL5RH1/U+V8JfPQ=;
        b=ptBoepPk//EbB7kCwy6n3CB6QjxcebihotUg6oZDQnlqLGTYfhpf30js2EP52R9R2I
         KCojxgCVkFgARTFNzPHA1iTT+3lO8r3NVs4Gt2Gm3tBU2N8QWxbpzUszEZRBjzOIxbxP
         Hoon5ku/4R/5MGoBaYPH/9l2DZD11MPUaptHTa2C1zTjYTdVy5K8PIA/Z1+pNxgDEbeT
         9OIZHpVSQPJ09DpR4VIBTsWK7IREf29JeFIjMm4qQ+JX5ncH0gbuHr9xo7FHd1b9e06Z
         3EW4uhyV/LaoN/Dr8E+j158FJmeLEaLnjW8+eiJXWIXDlkaSUH0igoG5sa3m3qlc60WQ
         6pCw==
X-Forwarded-Encrypted: i=1; AKwUvByhrhTjZAY0wTHTrLlNtgUx8XtvEA9vhPR6yf78OyWJobMYEyDo6F09zmK047VLCQvmFKzW3vw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVcgW3WZegCjVlSIxm6TOYTUOITDwswrQF1GnCYNDygnQv0+c8
	otxax4iqswm4SbGp34kNKy+YXRztHZPp4nh/jOVZwDd7+gyNycVgTqLl5U3VKKJW0w==
X-Gm-Gg: AYBFou1DWaZtsxLX7RoJvPHK1+7oFww/dsZWnBA+AlAjjOhIpTDohWflX1+JX/D43xH
	/Y249wWIiUeJCMGF3x4NiRMBEslOXabLg/ApfgdMEqIHUrjYkMiT6svoov2iGNO1hLojYK/79Ym
	gFQUk1ZIuiJy6CVtd+XzpHzYmkxNBow4Jilwf+odVeDt8e4QeDjr/vuveFgxBaETGYqduXNaNPU
	7cGlgPfDU1F0Jjgh48Nt5t2pHp9vKGPUCkMmAQ3mVrowU/sMPeBzBL2m7aAnH5d3Hp8TarjgnFU
	4VamGOprgo++kHnIOQL8spVzZh6/cF7+ZVx/XRVkRcm8mPgOX3R7wd2mrqUgvnzgPxVGIBXtFRE
	ZT0JNkAvo1R991ivuqOCDxHZymqw7HGl8jFDQWgcuBbO3zL7QaIUos7RtVFnLBKvK0RFjniJP84
	S5Iztk4cLCyS1pF1UDl3ZZcx6bwpUT8+9uPzXi42GsjbqP2PcUjzovODLxo0TCvjo8k4iSQTxQB
	TJqHY0ld7TCbvKCIz87u3kF57w+4cCKJMRTC7xyjHQ3Fs0K6aZNBSshJFBzwYOq+wcvacntvjq8
	MUi0x9BkpCbglLIkdSqKhb1gcEbnVLtPJXGFauxh89/CzbnG5JKAa+dzm6ccjN+2VmmoUIocOJb
	AH5JUM3aC6kORI39R
X-Received: by 2002:a05:6a00:a90:b0:89d:faf6:c69d with SMTP id d2e1a72fcca58-8a9c03b83e0mr969146b3a.58.1793334168419;
        Thu, 29 Oct 2026 21:22:48 -0700 (PDT)
Received: from cantal.lan ([58.136.77.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9eff2995asm231084b3a.53.2026.10.29.21.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:22:47 -0700 (PDT)
From: James Clark <jjc@jclark.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Aksh Garg <a-garg7@ti.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpts: adjust perout genf following ptp changes
Date: Fri, 30 Oct 2026 11:22:41 +0700
Message-ID: <20261030042241.2736240-1-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <c139c5e2-c791-46a2-8e60-556aa6402e12@intel.com>
References: <20261029135556.2508688-1-jjc@jclark.com> <c139c5e2-c791-46a2-8e60-556aa6402e12@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/29/26 22:57, Jacob Keller wrote:
> Makes sense. My only concern is how long does it take to finish the
> adjustment to fix the PPS? Could that impact the rate at which you can
> perform frequency adjustments? In typical deployments, frequency
> adjustments happen at every PTP sync event, which could be many times
> per second.

Hi Jacob, thanks for taking a look at this.

The register reads and writes happen over the SoC interconnect and so
are fast: I timed clock_adjtime(ADJ_FREQUENCY) on a BeagleY-AI and each
enabled GenF adds 0.84 us. I also tested with PTP sync events at 128
syncs per second, and it worked fine.

> Also, is there any loss inbetween when the correction comes to each GenF
> that could still create (a much smaller) inaccuracy between them that
> compounds over time with each frequency adjustment? Or does this updated
> correction keep everything aligned by the next pulse?

There is an issue here with how the hardware works, which I think means
that it is not possible to guarantee that the periodic output is
absolutely in sync with the PHC in all situations. The hardware has two
separate counters: a timestamp counter used by the PHC and a GenF
counter used by the periodic output. Each of these has its own PPM
counter used to apply frequency corrections. Each PPM counter is a
down-counter: it loads the period from the PPM registers, counts down to
zero, makes a one-tick adjustment in the direction set at that moment,
and then loads the period again (as described for GenF in
12.2.1.4.7.11.2 of the TRM). adjfine() just writes the PPM registers;
the hardware does not give access to the PPM counters. The PPM counters
are not in sync, so they can sample the frequency from their
corresponding registers at different times, and the corrections applied
to the timestamp and GenF counters can accordingly be different.

I tested that the hardware behaves consistently with the TRM. As before,
the GENF0 output was looped back to EXTTS 0. Writing a constant
frequency every 10 ms, there is no drift. But by writing a frequency
that alternates between +0.1 and -0.1 ppm every 10 ms, I was able to
produce a drift of 100 ns/s.

But in practice, this does not seem to be a significant problem, at
least on my particular board. I tested with ptp4l locked to a
GPS-disciplined grandmaster, at 1, 16 and 128 syncs a second, for 60, 10
and 5 minutes, and did not see any drift. I should mention though that
this board's crystal is 10 ppm slow, so the adjustment is large and the
PPM counter periods correspondingly short. The results might be worse on
a board with a more accurate crystal.

In any case, as far as I can see this is how the hardware is designed to
work, and I think this patch makes it work as designed.

> Obviously this is still better than what was happening before where the
> corrections weren't even applied.

Indeed.

James
