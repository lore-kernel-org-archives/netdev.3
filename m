Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2242922D7A9
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 03:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789961317; cv=none; b=VfuxBEuOVqous3vx6LUPmU2/Ri+J48As/qvtrMnevyrhnaXtNgEO9jgUTS0QDzKStaFkqQd0xFmsjkp3lPzeMMgLQt9gxBK3ePuupUxeeh6W2lLohFx4n4tQzRzgwn9Pm07YdLOp8jGoNgMHSMqGZbkJFVlohNHtaVzpw8m+2rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789961317; c=relaxed/simple;
	bh=uVL14eVn0VtP3x7RiVxged3b/dHuJlVAmCUkuezqZhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmLIDt67dER5dJ2s/Vm+qowHP/TpGk03mQuk6uEt8I1lpq+JvookrDeR/nitFOGg63MUJ96pU0uuGaj6Tz4h6SyP0jWYmykCMg3PYWzHEJ6uH/v8cmt0iOz53eH7LEvdYISxNIlfAOXRMlVdETgyMXxbWeKIF0MC8t6vlwNNqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sC/jYsG8; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sC/jYsG8"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d91ede8035so29684165ad.3
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 20:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789961315; x=1790566115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uVL14eVn0VtP3x7RiVxged3b/dHuJlVAmCUkuezqZhk=;
        b=sC/jYsG8uajKFklC6zmBTbNTGzCT4DfTvT2E62UwY49tFxwgDuZEp0+PMhbtkzAzOS
         WM6IQg6VsmBx6eGa2YdvZFsmZ1E+J0JCDgUmseOF6dhGVTS4ilshGIoMowbA6FJH1ca9
         0dycRQqeicO2tFMpRCf/fRGZOUqi86vO7KYjvlG2/W/qBNYvSoPjujtC1mG1EoqisnT8
         53NX1+VoD93/sZ5+JMDloFI9Xv6z977INgg/m0a+o+7ZimG9oVgCOvaL4SB/CvOJArfX
         cXe9xLSgOp6ggwj+95+8pssSVVfbi/R10EU/QAALeKWrJNXI/PaPlCD77jfJIOh6LNXf
         H4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789961315; x=1790566115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uVL14eVn0VtP3x7RiVxged3b/dHuJlVAmCUkuezqZhk=;
        b=zNhIaGfNtg5k8KqiF0lmess4crEcuwV/b6jotLF7GHq3QeVLRhEGoCTK2Xns3lFeTh
         y/bCOTesCAY/LNXrt49KHH6d6sXXUchgrnHsaCXOFNdW3LERNSaF0yH3zdBbl0HT4Jf2
         KI80Pikc9/29wxp5hUnhNoxocaZHqn6wcrs6jS9V8RSwXS6XI3vIhKMa1eaVyDwkaLWL
         /LLRB7yrSflyHfrCCZQoerssyhuRZI9mKE7lDmlTBlE91wP8uA6ytRQ4McJye1q1swdI
         Rby7hPlqiORZXtE7mRnxsUsvST2EHS6Z4QOp+yBh1GXtHOtDj0Zety56f6v2u/tknlGi
         e+kA==
X-Forwarded-Encrypted: i=1; AKwUvBxdfvpEv1mgh9FrgFieQxlJfottkd968Ds6A0By/KLNTZe04029fS2tBj06D6DgOkl4QXdgA9g=@vger.kernel.org
X-Gm-Message-State: AFuF++k+63R/pBH2MSBdiBax7plWASYK0bPq/jdg7b/+wbwkwN/pf3QU
	DbiRPdDo3cKI95bSIcGNhf4BGEB26gBr/zONDl0azCeWlkmsP5bkgqC4Qoz4ZtxGArQ=
X-Gm-Gg: AYBFou0Cz8WIJb4Wfq3IiQF6bX3N73zj/AcHnzanRB7uSYDbs6Bq/+wWed/k13Hhluy
	hqGJxMyaLgDNw4aQNQoC1Azalnafj7KX2xmpwIpuxzQbPzP+uCP79CYH3BOGgnj/P6tNepW5mfy
	nlp7l69/SzKg8BtKv+LmuWiGNIF/GgS4C4Hzx7bwN3gMWJS5JgOyccIeCxFaiP1DrF49htSHpWa
	kGM9Eu42vQS76ZGv1hkI9QkvMLF901D3JsfeCBPxEg/foaJuIB4PBh0yqvXETcALdphldFR6FEP
	tCr2/d4Vz4q4bGeWfsQ5s+U/OUtjnznV44FrMAzUd5a32XBLVhAJ6uNjouOtmOeW8/6nwEdanwn
	4tl0//aYGQKUA673t0NPemF9DPgdXM68A87Sb6CgxQpzlEFi4qEHHtukhAGJqfW3vjg9A7S0Z31
	l/NKI45bis+5qSCaW26kjVGT0toe2njU2yWv4FajUQWHFedpNtXfWsMcgu8sqrb+FNmxOqsNP9c
	RR75JuHnCh2KVqeURIqFD0uQd0Tdf3gFxQLTVAN4oTWdkZd029Bk4Hmz1egOV2vqM2Nc3HcLMg0
	YJE=
X-Received: by 2002:a17:90b:3d87:b0:39e:6c6a:6579 with SMTP id 98e67ed59e1d1-39e6c6a67ccmr8574108a91.60.1789961315385;
        Sun, 20 Sep 2026 20:28:35 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c37c8e7sm11448715a91.9.2026.09.20.20.28.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Sep 2026 20:28:34 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: emil.s.tantilov@intel.com
Cc: Tian Xun Ng <luckilystar08@gmail.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	aleksandr.loktionov@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: Re: [PATCH iwl-net 2/2] idpf: reset the function on shutdown
Date: Mon, 21 Sep 2026 11:27:31 +0800
Message-ID: <20260921032827.32485-1-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <49cbb19e-dcce-4bdd-8cfa-68fb2445f952@intel.com>
References: <20260917105205.37561-1-luckilystar08@gmail.com> <20260917105205.37561-3-luckilystar08@gmail.com> <49cbb19e-dcce-4bdd-8cfa-68fb2445f952@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 9/18/2026, Tantilov, Emil S wrote:
> This alone would not be enough, you need to make sure the reset handling
> does not trigger in the driver. Sashiko is also marking it:
> you will have to set IDPF_REMOVE_IN_PROG, though I am not sure if that
> alone would be sufficient.

You are right, and so is the review bot. I missed it because our hardware
takes the PF path.

On the VF path idpf_vf_trigger_reset() sends VIRTCHNL2_OP_RESET_VF unless
IDPF_REMOVE_IN_PROG is set, and idpf_shutdown() calls
idpf_deinit_dflt_mbx() immediately after the trigger, which frees the ASQ
while that message is still outstanding. That is an enqueue-then-free of
DMA memory, and on a system with the IOMMU translating it is exactly the
class of fault this series is trying to remove. On the PF path
idpf_trigger_reset() only writes PFGEN_CTRL, which is why our testing
never hit it.

I will drop this patch from v2 rather than paper over it with a flag.
It was never load bearing: the stray writes are stopped by patch 1, and
this one only restored parity with idpf_remove(). If it turns out to be
worth having, it belongs in its own series with the VF path handled
properly.

Thanks for catching it.
