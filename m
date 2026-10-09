Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E7367B73
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 03:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791516376; cv=none; b=QhaVdGqpper9PezHJbjAaJQZ1jOzwrgT7LwJpL32SOnJILcwBU1oCZxv3oiIiWrLWERRkW25O9vklx8IqMvFk6gGzhmAr/TTS+NsEcivF85hnPN3ZWNMtIllktpppCgCJ/3g6ym5A2lsYmcUvLDFlH66/3J/iT0d/dZiru1usgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791516376; c=relaxed/simple;
	bh=uXMGSSfFAEDHq8qr3JqW1Fw2+I4MsaoaXE/So5jxbD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5Y+5UyfueXcERrAgvPmdyoidcgChyIhPN6Dnlo29Zydf3nTOG7fc+u4T15co1kkEir6Cn/+nYAeqORZNyebISTv1zgfWV6QpgwaimyLp8biLh9nYApC8yq+XtMsxp/3nGTdKnEi6KSpF6xS9UUd99RAllguLks0eaOvCpnYtOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGrjKlNQ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGrjKlNQ"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-535853983f0so18532061cf.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 20:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791516366; x=1792121166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uXMGSSfFAEDHq8qr3JqW1Fw2+I4MsaoaXE/So5jxbD8=;
        b=QGrjKlNQ7nG0/3GLF7qmTFO6JNrHDey4JOal6viTXNeuFvUctZUerufqUPwLjDpTdD
         Rebha9RyxaG9GfN38rfumtF3tk0hyTYtMyUKz7iAfA/WHfBNgX/2btu/ehfUExNtWbh9
         T38liRO7I2JteVrrhyNibhOAfG4Tq6QN9zmzX/2fHB6V9udTavUk3Qhv1xneRnowe4rR
         Cw2lZO9l1H0e7pxFnErQbKYYm1m74ow+Rxm6Dz/rT8PsBAjMq2sEYYWw4UlC+zmRahx/
         vMgcnIPO1Zu7IVWY8w7ureBdKUi3/QcgbL67qGaplDuk7vIABlksJhrBoyD3UV72ydxN
         v0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791516366; x=1792121166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uXMGSSfFAEDHq8qr3JqW1Fw2+I4MsaoaXE/So5jxbD8=;
        b=FajBE5XYTzSTDsEEXI95xi4aa5e4C6BNW82iEpfrscd9FF8QuDsQTCB4SgxhtqRQL6
         JHuY6/7/5AuetvEKWgwLBW89tDnWs2r8uhidGiDiByT64roXiPbjKRaAPFvF70HGBcMU
         3qrjWvTLuwVbqq3hO7K2EG5l4YFnd8Gsf7LQ9PpsQfq+saI4kCA9qhTtW+cc9IX9WiW3
         lsdw3xIGpwc0UnKzk8r2OEz4K9LAnfy3qMVW26EHT9/3PtvKHBpddYOdyz6kU5kMtu19
         /vUWf4fbaWOOyIU/b6fMSsanKZxDLgbpaKigaSOnElxvnuHiq8EwzdnqXasR7h3I2zFe
         Mt7g==
X-Gm-Message-State: AFuF++m/ftePKPBgnHQpaniX/U7PKFjpp/ZVTkhQ0Oc7seFm1WNWYGkn
	QH0+PvEUU30le4bNpHQpa8jN+3WEkkgoEtkM/LVhlSoTltJ0cHj/PuT5XHi3/f9V
X-Gm-Gg: AYBFou1joVU0RWCOjoPW2zIX3fAHCUJI5+LvOvJJIHsonIOx5efwseQo8Gwg9fshlV4
	CCnyVeYUi+cpNtMCGbIVhSgd66Iuck9Gpe/xirjFs0qw0XM/MOiu1yTuNNlA1ohs26V6gdtGJ0A
	GRHwX9P4fldTIl8AlgUASDjLMWWiNr3dF5NLW7+Rm5tJNFvI1769i0wKCvR9br9flac+f7GJn5m
	MbCYpxUETz+WS600gF1TPK7yvx6Y61eq3fovnbUm9/eMTtjvwIO9F+3rbaPg1a20e8wigEy2L7k
	Fdq3QrfJTwVPYqls//Jz7Ec4tRhXkLrgTvakGMzTzrLCcIKRvvRrKomottJB7Vh+XoBl2hDXkIt
	OtjiO13Gj9p5eGCD4lK09mD9052ykF+EkVIoRF0ORw2JxVye1aV0z2X/V+3vs2cdzt+M1a2c6aH
	HaY5DPDhn5hzCLIHfvaQdA5SRNlOEx4Y1ICJNjeyR3I3h1uV5ONGjZa9jJMF/8Q9U9
X-Received: by 2002:a05:622a:c12:b0:535:80b:9911 with SMTP id d75a77b69052e-5359fac48b5mr10702091cf.24.1791516365726;
        Thu, 08 Oct 2026 20:26:05 -0700 (PDT)
Received: from houminxi ([61.170.182.45])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b6fa262sm9244181cf.6.2026.10.08.20.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 20:26:05 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next 2/2] netlink: specs: add ovs datapath and vport set operations
Date: Thu,  8 Oct 2026 23:26:00 -0400
Message-ID: <20261009032600.1759619-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179146490766.434549.3687648802927081770@kernel.org>
References: <20261006130533.1620706-1-houminxi@gmail.com> <20261006130533.1620706-3-houminxi@gmail.com> <179146490766.434549.3687648802927081770@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 8 Oct 2026, netdev-bot+sashiko@kernel.org wrote:
> [Medium] Should port-no be in the vport set request list as well?

No. lookup_vport() does accept OVS_VPORT_ATTR_PORT_NO plus the
datapath ifindex from the header, and the del op in this spec lists
port-no. But get lists only name, and new does not list port-no
either. Adding it to set alone would make the three lookup keys
disagree.

The lookup key is a property of the whole spec, not of the set op
this patch adds. I left it as the file already writes it.

> [Low] Is it useful to list options here? ovs_vport_cmd_set() returns
> -EOPNOTSUPP whenever it is present.

The list is the attributes the handler reads, not the ones it
accepts. type is in the same list and a changed type returns -EINVAL
(datapath.c, ovs_vport_cmd_set()). options returns -EOPNOTSUPP and the
policy marks it unused. Dropping one and keeping the other would need
a rule for which rejections to hide. The commit message already says
the handler rejects options.

> [Low] Should the datapath set doc also say how per-cpu-pids depends
> on user-features?

ovs_dp_change() applies per-cpu-pids only when the same request turns
on OVS_DP_F_DISPATCH_UPCALL_PER_CPU. That part of the reading is
right. The doc already says that a missing user-features attribute is
taken as zero and clears the features, which is the half that changes
state. The pids are ignored and the request still succeeds. I left
that out so the doc stays shorter than the handler.
