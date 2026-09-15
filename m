Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434FC3C4B60
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472873; cv=pass; b=c3yoOjeUJJlBwPCWaAm5VyHovVV31poZNrQpUuU0uAh8LcbP5k5cMtfrud3xEFFACf/JREM4p/j63fW4hfvtxhQ/xKHowTHaKNhWPga4nNMvXlNkcPWoyNi1RrPSwEPGaMjCjX84oowZbPLiaVF+gl6MBYMnC8zrIE02Owpdkis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472873; c=relaxed/simple;
	bh=s2Lj4pHsdIrh0iNl/yLPyohADV37fflTexKvvaB+Cp0=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgNmfQHf/iumGmr6+HLN+55A7Abnx1TKAv1JD0H/Mz1g3pGtPKUgLkm3qPROuJVHgc2333nCWRRmkyHWhMCG+JJfH4Ni6gruP9c9x6TD5DGXRb3dOCllPe27A8wsxhA3L82ymQ1oLBpQL9gkMqbaHOrpBWTSuSk52SrZpDYtC/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr; spf=pass smtp.mailfrom=khu.ac.kr; dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b=DizrHBiN; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=khu.ac.kr header.i=@khu.ac.kr header.b="DizrHBiN"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1b845so164393e87.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 04:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789472867; cv=none;
        d=google.com; s=arc-20260327;
        b=WNui+aqDN7bT+PwMFFWmddQMXjA9uUmo1N0QHv69U8laTO9Syadz/87lZx2tDuuLqe
         IV3hOwjGFCy2t9lsu197XyIrH7/X3pkmW30J5SldC6dohNPlqBqn6QEX2N2pv9WOJ1As
         G/K3XLhG7ekZGPhbne18gEwo7IqgNrmUprT5yQID5C2Ysqlf+lie/WBhEdpjbWr2LNCK
         li0XiPtX5PBJewi/+ssh//NsWd8w21HubbR6I1kw1I5ZbNL9jL4OzJZ178ARVqawCoJL
         vmgLxDN0OZ/LoqkC2tuUFLXa5/JjIoBUXQ3YdUzr5uWxkqLa3Blky8hZaZZW26JWQ0Zn
         D5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=s2Lj4pHsdIrh0iNl/yLPyohADV37fflTexKvvaB+Cp0=;
        fh=fPYwmXOPWOMFNXxrYPDh/Z+0GOTYd652KC/4AkCQO6M=;
        b=JfT+1bGUSu2d1xw4vFrC1K8sMVOeHTMHPyOzlL9l6J6WtTVE3JIQ5RBmXutKZfw5da
         N8AIKqBjTSTSJr1WzFF+CHVAIYC3Ko+zNM+96/L+4eF5USKUwDmF2SuuS2MGhKxLCOBJ
         HzqHhV6oL63RsXuoydmoV705T3b2oQPbTrsGJ7bSN7l9LxVNpmnrGl8ju4DTA7EAmv0h
         HzUxrOipeuoq7eEGog6DUd5aGTSc9PwWzcPD07hTJL7B9KV29ZvKZcxLAm/YdAHFuhvf
         ojJqZdhQ+322CkzlgTzCTtVCHBy+QFbQfRW6tWh5wQ5tWrPJ/p28Np1uuuC6BInchoig
         FMCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=khu.ac.kr; s=google; t=1789472867; x=1790077667; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s2Lj4pHsdIrh0iNl/yLPyohADV37fflTexKvvaB+Cp0=;
        b=DizrHBiNpy5Odi7pSYpRXre9pL8mOY1erNG1Q4C1IEckdpz8jxv3T8LMawhBVAqrd1
         q6aohvMhMde5+glFDYLuC+pG7rbGcQQJ/E6evA0MgJw4fUkRdd83xly/IKcjmlkjLQ/E
         XYu5EQ2xr4uTBeygVQKFxKhZReuIqMnA+60pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789472867; x=1790077667;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s2Lj4pHsdIrh0iNl/yLPyohADV37fflTexKvvaB+Cp0=;
        b=fC5hj+PiH3JoOcSlr3jiawhPmq24W2TvK6otZYR/JAywiu+4pJet2Eo4H5ckje+GcI
         ZZLNAn/4loYxf5Ztau3RYt8mMdbM93rpPIdoIZrEGf9CH6+dfdCIr7NZ912f6Rjej+Rj
         leIcU9GfmK1yNK+k4w/rk1eX03gxvBOuSF6/21GmERnZDgkn3eBf/cqpXMeDEwsnCHcd
         9z8Q2jxPLDWem4uP/ijawJbpBooL9ETnfBkG4xES5rHPTOu+lwllQmkBCSakIsCjrQWp
         1aSym+fOaJVAbZHATVumgIJchs2zeHFlhzzdeOtRNqgYNuFkduwlKdyMWe+pS0ITGKiB
         7Vnw==
X-Gm-Message-State: AFuF++kk+3lCQfrTkadFVp1TGnC+judtiPcUp7ji+lT34VtfkyTAVW7U
	bNKhjuyXM0aSWvKIVzgkrc7AzT0CSOv44gBeqqeMRy5VTehS1LhdkIMcaUeFarNzsN3ExSfN5Aj
	UqF5GHFpo511PfjXtlxTjtOjWFPCQ79dF0Xccg2s8uw==
X-Gm-Gg: AYBFou0qlPMFASnkolmTIBvfxEZI48WMi67bdlDoLdfQ06hAlY0NpdkOgUGWuHwjhyC
	aZMDZVHBr24jk1U9RxLVvmf1iVVRxVfF0V3AZVA0MVO5zeN72rPhZOcvqLck37LDiZ4hNX7quxj
	i/RywSZIHqwMuU6IEk44+I+EKvYepU5mU6OVsSX2iKEQodImjbseFandkwjjUSwkujfFc4Oyng0
	zdnn3TNPLWuAR2MwslH51F8ChTRTSP6EB/Nn3n+/WDzZoopfg+xBk2eSeGQIZDrofRHy/dIKkaR
	aQwlSr5A+x5Fyuw1vN9d4GfVb9BR9kzVbo5d7xiPrrdDA5oMrSKX
X-Received: by 2002:a05:6512:2210:b0:5b6:1a7c:aa1f with SMTP id
 2adb3069b0e04-5b8b4ffc4d4mr179859e87.55.1789472866941; Tue, 15 Sep 2026
 04:47:46 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 15 Sep 2026 04:47:46 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 15 Sep 2026 04:46:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: kimwooseok <5mghybrid@khu.ac.kr>
In-Reply-To: <20260915083839.71546-1-pabeni@redhat.com>
References: <178911388614.25348.8892025153904636456.macb-resend-1@khu.ac.kr> <20260915083839.71546-1-pabeni@redhat.com>
Date: Tue, 15 Sep 2026 04:47:46 -0700
X-Gm-Features: AcwNN1XcLqf7mtvLMWC_6Wsu1EscKIC8wJaYw3QKchmlCeJvSymI27SGWfnMzAA
Message-ID: <CAH1Bc_yQYJ6cWyYVvfWK0pAgrXW1TMkpzmNxZvAXAKZJdiOqWQ@mail.gmail.com>
Subject: Re: [PATCH net RESEND 1/2] net: macb: Preserve one-step mode on
 rejected timestamp requests
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, theo.lebrun@bootlin.com, 
	conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

Thanks for forwarding the review. Taking the items in turn:

TX_OFF / OSSMODE: this is pre-existing and independent of what this
patch fixes. The original code also left OSSMODE untouched on
HWTSTAMP_TX_OFF; this patch only addresses rejected (-ERANGE)
requests changing hardware state, while TX_OFF is an accepted request.

I propose handling TX_OFF in a separate follow-up patch, keeping this
series focused on the two reported bugs. It is a distinct defect and
should have its own changelog and Fixes: tag for stable backporting.
I will verify the TX_OFF fix on the Pi 5 and post it as a follow-up
once this series lands, since it touches the same lines.

NCR read-modify-write locking, the gem_get_ts_info() rx_filters bitmap,
and re-applying tstamp_config on resume: as the review itself notes,
these predate the series and are not made worse by it. I'd handle
them separately (net-next) rather than widen these Fixes patches.

SRTSM: NCR.SRTSM only makes the MAC replace the received FCS with the RX
timestamp nanoseconds in memory; with DRFCS set it has no effect on the
descriptor-based timestamps this driver uses, so leaving it set does not
affect timestamping. It is also unrelated to the two PTPv1 filters
remapped in patch 2.

Thanks,
Wooseok
