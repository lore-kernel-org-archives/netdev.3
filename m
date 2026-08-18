Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE933A59A7
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072669; cv=none; b=a/haWcIs9r9PbtZYp0JiY5xwdqLt8t8DnyP40Ka0/7aIgPueylSyGDpMdguXdp0zBqGjI1f6zir4ukijjwexdi6jO/8u+NhlNq5A7ZRev99jBbAwiMBAjZ4KOPUk88xOQY7qJcSCF4WztkScb/VayfcfIShMR7nuTvNbEIXf3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072669; c=relaxed/simple;
	bh=RzcrWRYAnas3w7gRJtgNkcOlP/3BOBx8AGcoQJF/vuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOsxE7N4m7XxUQiL1T9gwfRT+XsD/mOvF1FI+a6vCiKK4hYHu7A+jveai9N95zM3bgSKYyIK3zu1jKaXfQSBtpDkDltPKcOKmfMwyq1PGnHR5/CVxP6/WzoyOOnF9E5R2V8MMNeWaw4alv380gbe8Ty+aDDV1MIkcsMamGo081E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKYHA8Mw; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKYHA8Mw"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b45f1cd80eso101429e87.2
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787072666; x=1787677466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lrGDoBIL3iWhxhs+JqbF1vE+9puinMdhn+njQDs42ho=;
        b=nKYHA8MwUCGBOCpfiKjC0NIACkIOCMYsAGlX387Ok1ChQXy76EFI3vqyOZcJwO33lp
         89c9dksyEwe9Onk8SfZzTGPIJajxqYkgVIc0zUycIj6EC8PLf2Y5Vty+Ca9dTQ7uyqr2
         BiBbjozLhNiyqY8mPqhe7XeVUUnH4YzXgAWJtEJvtj2wg0zBkiV/tX9av0syKPCihzMF
         9tvVjxoVer+0rhwK4VRzzIZ0xZ2noRnN6muCQh2vGW+DSStlD/Ui/z4V8rpoiJV19W6+
         /0IE3AjitjmGszm6ZJxr/rxCAOjvWal70Rvqrwn7ZeiuT29nf3tCXFljL0YoTEQA9nc3
         jwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787072666; x=1787677466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lrGDoBIL3iWhxhs+JqbF1vE+9puinMdhn+njQDs42ho=;
        b=bOjgoCMVpmtBye+WpSeeMApBfEy3JUqj822uYSv9VCU0EtuvCtOp9hGsH2KubRS4eJ
         rX6SvOvlpFW+dohG5q2bzgU700malJmRk4TC1qjbviHOA5fCQWtLsTd9zyZk+554n/Ur
         vqkQkCmCtE/MU40b3o5IMvsUTJaWyUyL0flBhYbBU7JcPU9JZ8JNj0LPP+j4lIyk/nZ7
         St0LfcyAzMLE0Un5zc8WTvZLANswwhTdykPp4sTL4uIxHjCpw/6NTIrDaEcRZa0O2n6O
         d9oDncYuQh03BmuZdrvC5mm5vq8KFQ1EET2QBI5iZklZZao9+lhtSi2QhKTj/W5EYwqR
         Bnag==
X-Forwarded-Encrypted: i=1; AHgh+RrU37giCYkfACAKKkwqw/Gtl+ITO/fkWrCNwcJELFttIivpxLUOsVF4isP0oxhUPS9tsNoVJkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqDCCA/borPn5/kB4Vr9b7onaLabrdWsNayramnq6L4aiqTYaQ
	h1SyYnDkxopXwDmq5IZKUYMcrPNsm4fU4TiYkRH5hkWssG2aCu9haKE=
X-Gm-Gg: AR+sD11mr9kp2JY0l8Nxi5Qb4jJR+nDyGXEcC0tbSlicC3rfv1uFev9xlUsInebKXsf
	IB7gHBxHqjT9Y1/aDiK8To+lqVO5SIpMq5qrz03zepGcKtxkqV/J4kQmSoWSgE/2V7kL2NOTinn
	hmbzt1/XRrtM618V9CNQw/ZWuGf8Honotb3UZGLygstDZ+H4W7bnjVS81/MzpozqnLAfrvvs2rO
	slAq9Lw2IZJUhPA4+cL1Jcqu24WLFvZgs/d50ZdnVnHSSibO+9xhhfEmNOx8UvJy/KkBF11KZ3y
	4rtwuptjbMeLnc3CHuvycr8kscZT3xdzGCNwdr2JTi5k9XBuLl44BPWako7xNZxIIaDxSi2vrXX
	KLMl8VyO5PMuZiCMyzP/ceViE5vciOzndvAowkkxzqnX+aLxVaWmHSITI9fCUyu0qPIKc7MZHHX
	nXddFAvMi6rN121f/zcHVSEGfwYjCA7btTDUr1hTz6pcVTScT8siR0bIPqzx1Qew==
X-Received: by 2002:a05:6512:1287:b0:5b0:eda:de1f with SMTP id 2adb3069b0e04-5b459102745mr6076881e87.6.1787072666067;
        Tue, 18 Aug 2026 10:04:26 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46d01a089sm1367361e87.71.2026.08.18.10.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 10:04:25 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: yield the CPU on every exit of the threaded NAPI poll loop
Date: Tue, 18 Aug 2026 20:04:20 +0100
Message-ID: <20260818190420.21204-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817183356.4d90d878@kernel.org>
References: <20260817183356.4d90d878@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Please try to repro this on Linus's tree and repost if you can.
> Don't recall the exact details but IIRC the preemption is now
> more aggressive.

The patch itself is against current net/master already - that is the tree
I generated and build-tested it on, and the loop there is unchanged:

        if (repoll || busy_poll_last_qs) {
                rcu_softirq_qs_periodic(last_qs);
                cond_resched();
        }

        if (!repoll)
                break;

The exit path still reaches neither call, which is the case the patch is
about. So there is nothing to change in the posting itself; it is the
numbers that come from 6.18.

They come from 6.18 because that is the only kernel this board runs.
Mainline carries just en7581-evb - the AN7581/AN7583 SoC dtsi and the
board DTS exist only in OpenWrt, along with the airoha_eth changes that
have not landed upstream yet.

On preemption - I did measure that. Same board, same load, plain OpenWrt
without the patch, the two halves differing only in the preemption model
(verified in the built kernel .config):

  PREEMPT_NONE  worst "ip link del" 248.48 s, 8 of 29 samples over 1 s,
                8 classic + 48 expedited RCU stalls
  PREEMPT_LAZY  worst 0.39 s, 0 of 177 samples, no stalls

at the same packet rate, 80862 vs 80036 pkt/s. So you remember right:
with lazy preemption the symptom is gone. What is left is PREEMPT_NONE and
PREEMPT_VOLUNTARY builds.

It is not explained by the NAPI thread being preempted more, though -
nonvoluntary_ctxt_switches on that thread is 4.6/s under LAZY against
13.9/s under PREEMPT_NONE. The interrupt and batching pattern changes
instead. I could not pin the mechanism down, so I am reporting the
measurement rather than a conclusion.

For what it is worth, the reproduction is not specific to this hardware:
threaded NAPI can be turned on for any driver through
/sys/class/net/<dev>/threaded, and what the bug needs on top of that is
little or no interrupt coalescing, so the poll loop is re-entered tens of
thousands of times a second.

If a mainline repro is a hard requirement here, I understand - the 6.18
data and the unchanged code path is what I have.
