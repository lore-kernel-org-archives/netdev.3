Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD38407CD3
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064484; cv=none; b=A3b4011wtRS4YcZwNLlRSbXUH5vy8g8Mq47AUGm/i2+ji9fVhW/Ia0bDZeClbFO/IvLcYZloFB98dvtOWYar+tZfAUK4fzV0qii4KRfcy8lsADN0w8OYo2MwodXQTap2HIr9Las3aV0rD5KJD/j9PpSt3OnuG2Ej84CcXL0kyz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064484; c=relaxed/simple;
	bh=Xgr9P5NDRohHNy557cU23inSf3q8IPgz3jcsZq7IAqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRDrKAZCIFyHjWMGE/MSYDR7MCey37uGHHLIE8rTsOFGoubMQyIQH+W9T1ZlWx8vAtXqgl/O2q9nZVpi/x6EZrh3SMZ3a1o7cIY+fywJFN8X0fIsM+BDp8Qnn4P7ghgFlXVpYDPOO6Xywr7+b8xM8APiM4If8/mEryC5ufCqPGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltYACqk1; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltYACqk1"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso3209259a91.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790064471; x=1790669271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xgr9P5NDRohHNy557cU23inSf3q8IPgz3jcsZq7IAqg=;
        b=ltYACqk1NgRGIPzuHyjM+S8aRi+uXZiBTFqZ7w1wk2P26MexfhLv+Hr+0dDO1fMtaV
         YOcENv2MHNP8yjwnFatsaAEgn8O1yihs79Zona0D6GQovk5VJcMTaysEFNAaBOcXFbr7
         S3ngnI1LwJd9HbgoKUqGamrAn1hvQAOC/2vinHtIaLykJhs9pSzrBwsMgt4bUedJSIsq
         afju83H/hwUcW/AQXaaJZg7eL325xaQ3sm+HBaQjegMhuM6RDfeX7DbYI8b5NjY8iANM
         2ivk3zVrxghi49foV617+f4lmaccxH0ZVZ+NWhSTHzoEJ4lVWZ3UjylG7QPh1bkoESiJ
         SLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790064471; x=1790669271;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xgr9P5NDRohHNy557cU23inSf3q8IPgz3jcsZq7IAqg=;
        b=2iAg8icHV90P4+aTjhVqslQFH1KBWoSdpdmP3qeRgMMSqlXs9RRoUWIDkc8GepDaws
         jt6JgVvhXr28dF9fvepwgUVbwEhrV2C32h555UOjugLVZjRZRzCNlfV0KrwcC/ORi6bE
         dNB9zWc2hT5wd2bRZFF5FCebMROWjWbEUyFhpEGolDfKDp7pDiLQ7lmstn/JQ8NVE7Hq
         7lYSpnRqgbN+hrSSrmzmyBPsoT5/icHQvdcj/Maa9zq27NfSCGfjq92SxudvehKE7zi1
         z1sAWU1SiHBVC1j/ghbUDV7B9aCoC7fx20DoAmHXe7h42MM/orwjGMBw69bjsbCj74Az
         kmcA==
X-Forwarded-Encrypted: i=1; AKwUvBwf0a02df/v3O/i1sQxeBGb8aQqPmnAjmA8bd1xKw3DBtIXysLJOiSawTUgZr1bpNH/xpgzS18=@vger.kernel.org
X-Gm-Message-State: AFuF++l/yH1Mvn/sBE3C3gEfsya7E7h8QrunOY9EBtRDi8BXNZNNpKFN
	gunQezHnQMYI7es7i1hNdhG1Mxe3on/xMhwqyIroQ5bKeHo+/nfuzbVy
X-Gm-Gg: AYBFou1HTlK8uVfd4BZgHbXTrBjQyCbMkI5zMehFULq82nmSgIwPYkDxavUrdCfXFpQ
	4AnJP0FyF+X8SgUTqoFHjXj53RzscCFm4isL32wIZ8Jc0OwONfl/1THpHwmS2wZD3hzXHtBUUN8
	uGPlxq7BsLlOGvIGaqsgGcgkgKv51VlVULfnCRh9DXgLvIulzGMuWIpNDtinQUWEKWk615EspUv
	fIy+lDHMgQa30TYxa6ofgGDe7YqL5SXSUAjQHcTtqXUqIWLXoCvyiygF2vgtDYifUSGz/bRQcjF
	uOGfUJAvTzEYBajrR4C7koUFEHakFvvpzPp9mneR1pZy9CIZO9akAU4KNlXbl+m+K3gn69vCfVa
	uoMhT4JZQEu/cOSs1YjiE/L4QihyruPBxAE4zW27wZa9klcw6uX9gLlTE2u/8jtXsYrOsyylayO
	4BEc/99x8ViXv+k/quBkdICbe+uIG8DxHyQvGMym10s3uOjVQhwr8IjEy89LYV2Y7gW5arL5vs9
	Z2Jvx/pREHJstztQ6YTmF/u/x6AmPCiHUcpPriOPK3j70PZlA==
X-Received: by 2002:a17:90b:2e0e:b0:39e:6a7f:eef0 with SMTP id 98e67ed59e1d1-3a0731ef86fmr388880a91.21.1790064470681;
        Tue, 22 Sep 2026 01:07:50 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:c92a:4bc0:f68c:8fc1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06747204csm3350233a91.11.2026.09.22.01.07.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 01:07:48 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: Re: [PATCH 1/1] nfc: nci: ignore unexpected CORE_RESET_NTF
Date: Tue, 22 Sep 2026 16:07:39 +0800
Message-ID: <20260922080739.35915-1-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260921125805.224979-1-horms@kernel.org>
References: <20260921125805.224979-1-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Simon,

Thank you (and the sashiko reviewer) for the thorough review.
The points raised are completely valid and insightful.

1. Regarding FDP firmware update breakage (Severity: High):
You are absolutely right. In nci_ntf_packet(), returning -EINVAL from
nci_core_reset_ntf_packet() aborts the dispatch pipeline (goto end), which
prevents nci_core_ntf_packet() from running driver-specific handlers. In
drivers/nfc/fdp/fdp.c, the firmware patching path relies on this spontaneous
CORE_RESET_NTF to wake up info->setup_wq; dropping the packet causes it to
block indefinitely.

As suggested, in v2 we drop only the core-level bookkeeping (skipping the
ndev->nci_ver update and nci_req_complete) and return 0 so that driver-registered
ops continue to receive the notification.

2. Regarding ntf->reset_trigger (Severity: Medium):
The reset_trigger field is revision-dependent: in NCI 1.0, CORE_RESET_CMD
is reported as 0x00 (0x01 is powered-on), while NCI 2.0 defines 0x00 as
an unrecoverable error and reports CORE_RESET_CMD as 0x02. Hardcoding
either value would break the other generation of devices, so v2 gates
the core bookkeeping on NCI_RESET_PENDING alone and only skips power-on
notifications (trigger 0x01, which means the same in both revisions).
Power-on notifications never overlap a pending reset in the protocol
flow, and both revision's command-triggered values reach the flag gate.

3. Regarding nci_core_reset_rsp_packet() (Severity: Medium):
Agreed. nci_core_reset_rsp_packet() now checks whether NCI_RESET_PENDING
is set before calling nci_req_complete() on non-OK or NCI 1.x responses to avoid
prematurely completing an unrelated request.

4. Regarding NCI 1.x response length check (Severity: Low):
In v2, we explicitly check skb->len >= sizeof(*rsp) to ensure config_status is
not read out-of-bounds in pr_debug().

5. Regarding request serialization / stale notifications (Severity: Medium):
All requests are serialized under ndev->req_lock, and __nci_request() unconditionally
clears NCI_RESET_PENDING before dropping req_lock. Filtering out power-on notifications
(trigger 0x01) ensures spontaneous controller power-ups are ignored, while checking and
clearing the pending flag ensures each command matches at most one notification.

6. Regarding request generation (Severity: Medium on both questions):
The NCI protocol gives notifications no request correlation, so a stale
CORE_RESET_NTF/RSP that is already inside nci_rx_work when a reset times
out and userspace retries cannot be distinguished from the new attempt's
own frame: the flag gate and the trigger check narrow the window, but a
generation identity would require protocol support that does not exist.
The failure path purges queued frames; only an in-flight worker frame can
straddle, and the data it carries originates from the same controller.
If you would prefer, I can add a per-request generation check for the RSP
path where an identity exists, as a follow-up.

v2 patch has been sent as reply to this thread.

Thanks,
Yuchao
