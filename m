Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED39470EAD
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789924004; cv=none; b=QW5lpnw22XnnrvHzyw3WhAuHquyaGl47wHfNb/+NTvjSaqoV5tKDSpUT63j/vLlGdzQYVgkp45+p11+lTQr1HgjdglZzYgAGUPR74ub69sPmJz31MHDmpXvMr9tyybmizp46qPB9mMhNmYhz5Q49N2SAwQ/p59+RglyXyfMLsaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789924004; c=relaxed/simple;
	bh=anUHqomupBKyPucADmKWr9oN0Lgpc9m6vAMueRhAlHM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=ij9ahJojMbEm03ufN4H/fPxM9tEC/g/qtL6npG873plb9IEBcSbeaDLLhAiZXq5rSxrBa3FliPTKdGbUCYdhqBnD2t4WcTpST8yPPHYS1RIwDUwCK8Q0NJhPui4Lmx/I2aQ0ntaQSiALnsm9Oi8Slv2gUm6Lf5P0Fvb+A8uSsyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nxIcDwdW; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxIcDwdW"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1a94so1546348a12.2
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789924002; x=1790528802; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KO1TTBeh5iVCqAjmzagpi1LUqmont0PjLJhUCpfZPPo=;
        b=nxIcDwdWDjBJZS9ID3vArupICAVAo9uuDSrADAxhxNFy7Br3c3xfHcCv4s2lW58eq9
         ka7dfoKV3Qm21Ij8lojw5vilLHVik4UMe2ubopT7aDZXzH9pBXNf1GPdHJyNlprfKFMj
         5LY0/j+n3sHrmBO7GfHMrFKQoyxX3jo8MQa+jOgea2rTdW5o/Z50odX+/dCoT5IfJWjd
         BIW4k4P1raSU/506ZdtdXZYKQJApsGpyOhOExFWDPmjDcMvuFJHK8AEnRr+/jzy5cHT3
         o28Y1eeHIFe//C5JFHIbCT0mFYuOraLLo2yeHrED4eTlZRukUknUVy6kFW5UhhZ9JsS1
         PVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789924002; x=1790528802;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KO1TTBeh5iVCqAjmzagpi1LUqmont0PjLJhUCpfZPPo=;
        b=x7ob0mw1j9JE55MiOVjc5310jKCs/cpUMtWcaDDJ2EBSwUpTmRuesmMTI40WPkOeIh
         h4lNNqIZntBEgYmix7OquAiBlV8t6xxr6cRRq8M0E5Yn4CqPEJdKvBhUEhQHINqylfGj
         TFuZ3wOCcRDmg6B/ytc3VqLzvY5X85667aw1fxiGtOJEco+T846NbVukAlK4Gm9O5Vrk
         RwIaH37N7zVEkB5SyjKOg3kDsZ774VTtP8vztNOZXFLxf0jQqaBYm/NOncK1RToaHp0I
         zCR6pHR0UCJ4QbZmIco8Kn7a720EkZbVHPcJZc1qzol8svsZKnmyVZI6hEcZ9E91Cr7W
         M6sg==
X-Forwarded-Encrypted: i=1; AKwUvBxkIRib9xRtLYqqLH9F5GJnArF6yUhDJOk/thEshR1UKMDsTQ/QmDf6pIVMnqhuGK6NCII5Mgs=@vger.kernel.org
X-Gm-Message-State: AFuF++lCPSE0eAk4axXQHUeRpVGdyJpCtlDCTHIMxDDwyvwss0UhQULz
	90oWlZt8wVDpi/Tw97Y9IeRTgXke7AV2fSWdi0PQDC9JdJfCXyvwmavt
X-Gm-Gg: AYBFou2sUO0Aw+yk3hO+TRnVq5Uk8Y4R0b/RwIcvR1mlT7EHHHpz05s7gzCS4woMAe3
	pf+HOlTLctIKTM4yKwyu2LveWVcEM+0M1Cu2QQRmfQP77NZ0Dy84AcxKNKtscdLuivWVJBhbHHE
	zF6YXAAy86/9D/XtoVBspMbSPBr4aSamHvAzcXRTl6GgVzfmlB61xquKiQKYPZWa0VvKfKTC/1/
	CLeGlf5ghWV4mZQKfFPpJsDOr4dnsQpXfwpsSRidASgkE2Sdja5M52LP89Z5M9VM4jtR87j+D4l
	zKwI2YFgFGuJJXQmGEmP2MtRr8wwY4NqlO4rw/2U4UN9LgEkIYSd44RlIERaHwp+6VkJ5BeCcER
	ubyz2EkK/3PEg+/L35XeXEDdyRhCYbmQKtCwwt7PgKRJdCXdul2x823WdUPGTUjPISHC9AE/KGR
	qRJzeYRafg0jse6lxChmY3iJ3NsR97P/jUEA+DvcMz6+3T85yuMC7WMCGOpY/RFNpF27FR1iyDZ
	6lI4sO+fW5rYgbI/W69/3bB7HV7VpyK1x/4k7PHFGqJWJor2qnOtbGY3WfHvCH2qd0nGOtM+wDW
	hs4=
X-Received: by 2002:a17:90b:6c5:b0:3a0:295e:6e58 with SMTP id 98e67ed59e1d1-3a0295e7719mr4719850a91.2.1789924002207;
        Sun, 20 Sep 2026 10:06:42 -0700 (PDT)
Received: from localhost ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a038ff8c39sm4175693a91.7.2026.09.20.10.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 10:06:41 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Sep 2026 17:06:40 +0000
Message-Id: <DLKB3QCTZH4F.243J1I4BAEBOA@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Peter
 Oskolkov" <posk@google.com>, "Xiang Mei" <xmei5@asu.edu>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] bpf: propagate cb_access from freplace programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Weiming Shi" <bestswngs@gmail.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>
In-Reply-To: <20260920163211.795547-2-bestswngs@gmail.com>
References: <20260920163211.795547-1-bestswngs@gmail.com> <20260920163211.795547-2-bestswngs@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 21, 2026 at 12:32 AM Weiming Shi <bestswngs@gmail.com> wrote:
> Cc: stable@vger.kernel.org
> Fixes: be8704ff07d2 ("bpf: Introduce dynamic program extensions")

That shouldn't go to stable. Loading an EXT prog takes CAP_BPF +
CAP_NET_ADMIN + CAP_PERFMON.

[...]

> +	if (prog->type == BPF_PROG_TYPE_EXT && READ_ONCE(prog->cb_access)) {
> +		WRITE_ONCE(tgt_prog->cb_access, true);
> +		/* Drain runs that observed cb_access=false before enabling freplace. */
> +		synchronize_rcu();
> +	}

tc doesn't look at cb_access at all, yet every tc freplace that touches
cb[] now waits for an RCU grace period in attach.

This is a separate issue from the LWT one. Patch 2 resets the cb after
the run whether the prog has cb_access or not, so it doesn't depend on
this patch. Pls drop it from this series.
