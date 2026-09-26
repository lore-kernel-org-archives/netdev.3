Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC2E368D45
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790422541; cv=none; b=R6gi6qwR+J7RW8jq3zPLAZDtt5VcC96siE35wk+l8x460M3/9KKeA26UsdIdaahc7EGXhA8i1HY7ixROSJHV+HUwanWs4+MzNNKYr6uxi/bHW6JDzv9N4sKvyLsVvPfdx9WFrmIaOV5mXtSGiqo+/909v0dPsHctLzZlBWcHdAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790422541; c=relaxed/simple;
	bh=elejCM3I7aiBIJk4EokP1CKIsPf6qMSVFiV7ceA0xps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoQfQ6cKZuFiurWB+L/RdaovLUSJ8tf+uYmVVkXSgu1a8NJRLFIJSHNsTRmIPFhA1GOR8IobJMf4fP+iOXs4OuaHzyWwl9vwdyLcpNvMV8b7aut6WxwveYFYjVs7P5STRi79RZpySyt4SyRK4ITG/tRaonP6J88Zmlsr1Oeerrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWZywTzJ; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWZywTzJ"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2939b2e4caso23007466b.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 04:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790422538; x=1791027338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=elejCM3I7aiBIJk4EokP1CKIsPf6qMSVFiV7ceA0xps=;
        b=iWZywTzJ4zNVBCDWtzmj0royJOaD/WQ4wN7PdQ3J5YC3Ud36DGUyZTwpioKZ4BOQID
         XGnkVPCKZ69yiQPfUYIy/luSjy9uDTDUZ1pOdMQnG3BXVysJFEOAPSOC9bqonWSRUMIM
         p9/GmEfRxy5po3qxgXsdo6pLLpLPBmTWcvJs68ejPWVACU40rYsvzV3QxooTdUqOC/Ie
         wmBuTggKV1EamTXEufkq/9o5QNauEmwa/Jny3xY7BVp9O2Rs5kW/Vrn/7sjdU17JKzJt
         yXjgFufzpfpIZOPSdWQK1dHrn1qttrYZbB6C0WeLPOxZ8RIKJ8T7mwEof4MJHHQGj7e7
         9eDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790422538; x=1791027338;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=elejCM3I7aiBIJk4EokP1CKIsPf6qMSVFiV7ceA0xps=;
        b=1E9cI0c1cMfKGJGhPOpWhtK8AKY7LGxMEBufGpnA9uySQbQ77CRhYXdxXGC9ufNoF8
         6iTVNDxbx5rpNbpfivkwhZ7v23XCtD2vzaHusfjPjwyWBoA0g7dG5LOb1YTMrHyBeTwX
         U4QqX5I3QJQOlysna/vlwjRi/niz6pyMEYBuB1Vno7hkEhimp6W3KI0EJrpitIMZEISa
         Jkck5pWgVz01WgN5omYoCkfnrL3x7EBXEfKNMEySoR4zX0zvXHQWXxgO0U8GL84cl0nK
         xxS5vkgaR2SmkKKuz87GN1GQE/vhpwjMEs6uEPEH7iKzwSvImMRD3swrE4YH5XtTWPdc
         KSNA==
X-Forwarded-Encrypted: i=1; AKwUvBxuvMJc48DQV94eI+kbPNvP44wsYLJz4X+iFeJRaBtyENi8sz9sfjavs6NsN/dvDY/NT0kYZ8o=@vger.kernel.org
X-Gm-Message-State: AFuF++mKpcZkx7xxl9pcAyH4+C6z5jz20ZRvUgpMdev3qgHUYPWd2gTv
	kWTI7axDjntXOjkVQDMVvTeMoJcqQr1zsJk2GwmMHimxBfX0B7QqdHbl
X-Gm-Gg: AYBFou1DWw26cIAWwXmPPfzSqCSLC1vQqapH7yFzTL7hHAskAlX2SIRftubp2d5aTxG
	Jkg4XrhP5KVr9vk0VGvsLI+H6OG0uMc4LWXpxvsA2Ue7PvZqfPGEwNM4svTS/AHDDIv2kgoGVm4
	JIaDbn31uD5TkXBkhJBLaEE3HkcT9VIV2T0+AzTVIwvG8c5Jay5c6E4+X3ZR1jmhFvlR2kEWzQ5
	wBhUz5PCrpcMK4+Bqm0nHQ6uAeLl2q/IApz8f5XDf08LjkNfsh5LxwgK3FFofnEEwB6s9zX8G3Q
	1f/1bOW7Mlj6gH5FQvDTSHytS33bnLH2t/jXufXMxFAQ0LLa71ZqUliBLXHmUupib9czNZpJRxf
	tv3aTXQp5UG/moTS7ri+2sFfHa83ntx62k/M8pqjaeg4LMqoAUjJ4XAFJThcz9HLWlDkeWaUfYu
	x7i/TeZwdYjDIIkuPpRojLlCwoco8m7S8GjbrHIPfTwI+1Wvjbr+pLOyg2JZHP6/H4bJhrC/oiI
	wEQHiDutNhkb63ZpYg=
X-Received: by 2002:a17:907:6090:b0:c29:39e2:4aca with SMTP id a640c23a62f3a-c2adbca5396mr461262266b.1.1790422537754;
        Sat, 26 Sep 2026 04:35:37 -0700 (PDT)
Received: from Nuel20.localdomain ([105.118.3.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2dbd3a046asm42887566b.69.2026.09.26.04.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 04:35:37 -0700 (PDT)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	mchehab@kernel.org,
	aleksander.lobakin@intel.com,
	aleksandr.loktionov@intel.com,
	tudor.ambarus@linaro.org,
	bvanassche@acm.org
Subject: Re: [PATCH] docs: kdoc: fix struct_group_tagged() parsing regression
Date: Sat, 26 Sep 2026 12:35:26 +0100
Message-ID: <20260926113526.65577-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <e8344a91-b2a1-42a5-b65d-e02939103108@infradead.org>
References: <e8344a91-b2a1-42a5-b65d-e02939103108@infradead.org> <20260914155127.21515-1-emmaonana18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Randy,

> Would something similar to this work for this warning?

Thanks for looking into this — and for spotting that warning in the
first place.

> Warning: include/linux/debugfs.h:246 context_lock_struct(debugfs_cancellation) { struct list_head list; void (*cancel)(struct dentry *, void *); void *cancel_data; }; error: Cannot parse struct or union!

> Even though context_lock_struct is in xforms_list.py, it's not working
> in this case (above).

If I'm reading mainline right, there's no
context_lock_struct rule in xforms_lists.py yet; nothing in the kdoc
tooling handles the macro at all. I hadn't seen your message before —
the rule is something I'm adding in my follow-up patch "[PATCH] docs:
kdoc: parse context_lock_struct() as struct declaration", which is
currently in review in a separate thread.

That's why the warning shows up: there is no transform to run, and even
with one in place the struct transforms wouldn't fire, since
dump_struct() applies them only to the members after
split_struct_proto() — which rejects context_lock_struct(...) first.
So something similar to the struct_group_tagged fix would be part of it
(the rule itself), but it also needs the transforms applied to the whole
declaration before split_struct_proto(), the same way dump_var() and
dump_function() already do. That's what the patch does.

Thanks,

Onana
