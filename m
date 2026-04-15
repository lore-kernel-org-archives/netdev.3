Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C82A395D9F
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776273813; cv=none; b=pLKxv2Ab/R4vcGO/xQhQmGCtYOa6zq1dCqKnq2pdJzEd498BA2ErPqF5olX6Rs4h059JlgyfF6KozZwYzngJ4EsTJvsccyJozy+UNxG+7DeJS8PYbHttR9AkBoKNSp3rnMhvdU/3QkhQxNo7gEkh2xhGikgt8szicY4QiIpFfvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776273813; c=relaxed/simple;
	bh=mpiW98q5chB3jszBp5OXfQ1hRIuKU7nwacyQchk257U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=imHap76Zn6Z+UxvrYZ9zXBSb0OV+G1BalkIgdUnu72eo7o5a0i5hJJJo4iURcuqrYY8JfgNwVg2ZNPqPPVAFwW/QPvEAVM/9WzFmxc10NkTxHl47dKwajCz8YFNN5Za/pmzlqbCGuuUiKplH2TEBSIozKolk0fGStgI+kHkLFSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBvTTE8a; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBvTTE8a"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so7631084eec.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776273810; x=1776878610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpiW98q5chB3jszBp5OXfQ1hRIuKU7nwacyQchk257U=;
        b=KBvTTE8a1mEX0n5ee3suoG6vnre8r0VQSYC3Z8kVmp/bulTZkImpUjiCTVGRwE1PoN
         MqAJmHBHvIlTCOPVh0TH4qDI0KZUw3FpHFjesFyH9IxhiKEksQqcC/GbJDp+LSHepgGI
         NkYWfluGQOF6ouigZUpThu8l8MBPzmEr0fOTpmPtGTdtqVX2iz7+0KIynxOxza6efz9H
         2ltl24ozJItfGthqUFxBMnDgJIrOk9rqQMIEMtf/RAaVmuMFfF4DiWgfIrqCPs87+Cvt
         SEwxmB1PY4D9ttRcA4ZvNkTpXkIzTT5LtrWc2xj/13yjgDoztAxLQJ3bClxgSsFBuFFW
         DuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776273810; x=1776878610;
        h=content-transfer-encoding:in-reply-to:from:references:to:subject:cc
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpiW98q5chB3jszBp5OXfQ1hRIuKU7nwacyQchk257U=;
        b=IupDVWP36gWncY/upMZ/4ucfOgisVGsFRQ6mZKncGQF3yknfswcmBH3aQjbMJ7MgUQ
         la0Sf8jb+ewiPRotnMiYM9SlJRc3xeleX2fc3Rjmy93YEB5L0oHl3A9ht7PShv8dRegu
         LQcDYZJz86KbuLAf55ylyu/pVPIghEyW2XjcRhVehn8fVGQGqcfMv4Y/YR/pJNGlxcJi
         RBZi0ce9gupU3ZrL0b9ncpNaTyZd6aVjo3hlZl4uNM+PkIlhgbCr1uSd3SLoc2/SxMbO
         ek40b+hi4wl1ntX4/BedfttjuNCwT0BHNonlcBzocOe7ccfATXjGxb1Qfgd7hIken0P2
         2PIw==
X-Forwarded-Encrypted: i=1; AFNElJ/EiEvCKrG70IY5WZxQM7RZ6smPRvvlXn3DxwieJ3mT726SXMtAKZiL0nTYD2Yk1qfEXhJ7jLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe1qu9tUC559raJVGYbYOhOAWRwKLYziq1+X2gIQoDA8aYgHE+
	5uDWW0z6GUj66ZuriemxfxmUHp87M3DHrdn91eoSMrPViUFCaPhxLyce
X-Gm-Gg: AeBDieuf2V2LPwr5g/SKtCJv8UN4oYjIIPvHA0mQN+XnYpjD5V5Ixa36XiEdnl1e6Yp
	ASH7eGOpNd8A6MezNCZoG0GI4+n+165eefTzbJ8dcTvlmPVfMsqlIvpX/s0xKrq6qt9jvilnFpU
	Z/kqMEDqfYEXb5ndRs0DlYiy6g7XD92O9mMnSoxyEi1SmXXjcV1uxt1iYrriD2QqWSzkUXj2fSR
	I9eBo2nBvmdZpQSgWMkafwyClnOjBy3r/GysQ5bex32qWP+bkcfAZk3fg7Th7NVVlODs261RLW+
	kXE6Bh/+ntJfGzLTrAY11vGMD/TdAzmMglTZlLllebzAwqnSVJwsVMsduA4ZzIzsOzQNEH88hNP
	kRNemcMteb1RqrxpNeri43eHa/itGGcBUCAk6gb76z4Muoa1CR1wspWDfl6NAg4CM/HXpJQJv99
	jmaeYFPkF6xjn5Bl+PnLPSic61j1Xi16a7P9C/BWrROWJOHyo=
X-Received: by 2002:a05:7022:fa8:b0:128:d2a5:709c with SMTP id a92af1059eb24-12c34f18363mr12935629c88.33.1776273810099;
        Wed, 15 Apr 2026 10:23:30 -0700 (PDT)
Received: from [10.0.0.2] ([169.235.25.186])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f65fc42sm3485269eec.23.2026.04.15.10.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 10:23:29 -0700 (PDT)
Message-ID: <2fbe2fc5-0e4d-4a87-93b7-9b23f8b3a16b@gmail.com>
Date: Wed, 15 Apr 2026 10:22:06 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: yuantan098@gmail.com, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 sdf@fomichev.me, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, bjorn@kernel.org,
 linux-kernel@vger.kernel.org, yifanwucs@gmail.com
Subject: Re: [PATCH 1/1] xskmap: reject TX-only AF_XDP sockets
To: Jason Xing <kerneljasonxing@gmail.com>, Linpu Yu <linpu5433@gmail.com>
References: <cover.1774701288.git.linpu5433@gmail.com>
 <6584463e576b7bb3619dc302cfecfb8ca56bc86a.1774701288.git.linpu5433@gmail.com>
 <CAL+tcoAy5WQRsL6z=YinPaiBNvd_=WB7qsR4amf1x4=qVw7AAg@mail.gmail.com>
From: Yuan Tan <yuantan098@gmail.com>
In-Reply-To: <CAL+tcoAy5WQRsL6z=YinPaiBNvd_=WB7qsR4amf1x4=qVw7AAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/15/2026 1:43 AM, Jason Xing wrote:
> On Mon, Mar 30, 2026 at 3:33 AM Linpu Yu <linpu5433@gmail.com> wrote:
>> Reject TX-only AF_XDP sockets from XSKMAP updates. Redirected
>> packets always enter the Rx path, where the kernel expects the
>> selected socket to have an Rx ring. A TX-only socket can
>> currently be inserted into an XSKMAP, and redirecting a packet
>> to it crashes the kernel in xsk_generic_rcv().
>>
>> Keep TX-only AF_XDP sockets valid for pure Tx use, but prevent
>> them from being published through XSKMAP.
>>
>> Fixes: fbfc504a24f5 ("bpf: introduce new bpf AF_XDP map type BPF_MAP_TYPE_XSKMAP")
>> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>> Reported-by: Yuan Tan <yuantan098@gmail.com>
>> Signed-off-by: Xin Liu <bird@lzu.edu.cn>
>> Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
>> Signed-off-by: Linpu Yu <linpu5433@gmail.com>
> Hi Linpu,
>
> Any plan to post a v2 with our questions resolved?
>
> Thanks,
> Jason

Hi Jason, Linpu has an exam to take this week. He told he can try
preparing the v2 patch this weekend. Best,

Yuan

