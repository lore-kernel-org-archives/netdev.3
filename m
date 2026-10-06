Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4063B05AD
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791284204; cv=none; b=HcyOshE9vAZLUwFyMqY9qc7bfNdSLHkfpSFrnHO7+UMGPSjuFjEhYL6IJFxDz2HnjQVtWXtJHYJmNeFe0uZt1vpQgGn0ndHDETraR+ijx5BgfQAf77mUIXTVBWu9+sJep+xxml7MfvnwfCrNlzZ2bK+8cciG4NZFOl1xhzZ41xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791284204; c=relaxed/simple;
	bh=LSuG07DL7mAPTVH9az1Diu30JUobjqfVoqjem5H3Ibg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F8Png6AoIvARTwm/VimLz4HdRJozYFuuPofIh7a1d/F5xDnyH/TjKlMDtvSoVxscOB+oQ3rYKkybRfc2mAzxhbGzzpWa/1tU3hijJ8VqyLComHW6YeAj/haB22b83FLb7A9HTNwsC/i2yT2+9ssAeLXK1B9zWQmZ2nLW6BXvyRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ss0YH7v+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ss0YH7v+"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so403779a91.2
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 03:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791284202; x=1791889002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NI6ZURTheFOwf7xfJ3T7rNEzU2/d53FWKsUxLaM51H8=;
        b=ss0YH7v+btHjadIHYpj9zLqBZ3y3UTp1VEjs8amz/iF7FgNR1j4Xjcho9R8yzQ88U+
         G9eV2W8QbX/gSEHGFk+qJw8mQ/gvGVr+MMTC06CfQrupj3EYQDjhpobl2bev3U9VThlo
         J845VdMSr2wKOzwsXj9xLrhdybkijIcURYbFy+39A3fiPM7iskeoGWpmhyE9zdSsuH46
         dWsPUKX6I/uhaJnezblkycTSEBqBY7AfJV6X4hm3pUSVgfPxy5kGvGERJ857L25P29Gq
         MSfQ1THKaZ/1suJeA5RVN/tJDdFnqQRQYhGky7XYS6K7gKa2oVNZNpVRbP7nEm3roLjE
         w1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791284202; x=1791889002;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NI6ZURTheFOwf7xfJ3T7rNEzU2/d53FWKsUxLaM51H8=;
        b=lF78dZZvbw6wMyvceRUVjyqTTA7xZvfgxge8brzgjJct5OdGz+rLW9a+HqH8baA8Kv
         3dAplxP21/bLBJYRo2Raz1nKQiHIKSEpqjABcUym+JJRRogV0qyIT929Cger2u48lpHf
         JZlHK1bXK+sGp6m1e/M399bbji3bdRlSsEzqfLz4i+NZiYDVkbIRbAOwmC67jtk0DKPf
         y54OUASvdnaLc6Z9HCzRNPI3rqT4ZvhM97y4TnHSGunRausYvw/pU7L82Whd5Slk83V1
         d8Z0yVCjsqSdFlYcS+HnpP/V4FvHeXd/EFejfV7bVh6lR1sAc+f6U1fFoaWKCTriywrc
         BWNQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1s0eTyeP4m/6H8kfvvue3lR7UlYcrpH1MKlkgYMsAIonlZqTmGANwqL6WjanmJVeKVXTI9fk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVMLo1eqHswwP/lcSwcE9Ltma0lEgknewT25XTKVSxo0lvtd+s
	xovxx4CLbyvVHawxS2hMKnzMWv8jYRB45PBxheS0tVGYONyAcDLac6Dq
X-Gm-Gg: AYBFou0n6bR9MZXV8q0ZeO+fzVdkLiiCCcG4gq10LT495XQP725NoSbGIjuAJkIuQtr
	TuBO73g1rF5lB3W3eC6dujMxaIZiw+EW1EBUWGbu0W6TvPskBMFrWJYZ2kBbeMvHgvmbx/vMUBH
	IIoi0pmE2AZa+/Nl+LU2cVNwTu2djahCuq2xAmdIWQWYIfA+FHNFJUROOFox2TRN9bi10ljgAmi
	pMPAhDDUGapqSdl5vxHGE2JQRxR9juq6jfxbmu0B0/5IakKbVQOWlW9OZXtSboBQyhpv1jBZvm/
	dpOGHvavRcBdXHBZjmcH+ivhD6rR5wwf3MQ189RWJDIT+fx+0VkKQNER4YJjjsVSwFWbeT0wD3B
	Uc+/kSebyXXS3zuNnnJ37RZv1K1IM0ZH01LqdCrtgEx32G6OXk+uFFCnUoc4SlhxqwwTDErGG9T
	UIDv8HKZGMuKEIJ2FcrU3UsfVJrfQFLQ7shqhsKn1AxxWnFK2AZfMmrk2vjcaDNHlrw39HVOmGZ
	ZbRPtLiIlOmQFNYu4GVv+tHhAkW9gyrZ3GwAEjmZ8nh49XdnWutMq+PbYbuCcue1TfY02JfDLGQ
	ikF7gPCGUIZJOA==
X-Received: by 2002:a17:90b:5825:b0:3a4:b0ba:8e4d with SMTP id 98e67ed59e1d1-3a8730e713dmr376259a91.13.1791284202002;
        Tue, 06 Oct 2026 03:56:42 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a85425eb41sm4735366a91.8.2026.10.06.03.56.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 03:56:41 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
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
Subject: Re: [PATCH iwl-net 1/2] idpf: keep the mailbox up while tearing down vports on shutdown
Date: Tue,  6 Oct 2026 18:56:29 +0800
Message-ID: <20261006105629.7481-1-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <008a657f-f914-4191-b5c6-0fcc062bf73e@intel.com>
References: <20260917105205.37561-1-luckilystar08@gmail.com> <20260917105205.37561-2-luckilystar08@gmail.com> <45ffbd03-653c-46fc-b500-07e9b99f295f@intel.com> <20260921032827.32485-2-luckilystar08@gmail.com> <008a657f-f914-4191-b5c6-0fcc062bf73e@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/21/2026 2:06 PM, Tantilov, Emil S wrote:
> In that case wouldn't just the reset on shutdown be sufficient? The FW
> should clear the resources on reset, which should take care of the stale
> vports.

Sorry for the slow reply; I wanted data before answering. On these
devices it is not sufficient.

Same arm64 hosts with two idpf PFs, IOMMU translating so every stray
write is blocked and logged as an F_TRANSLATION fault, warm reboot in a
loop, counting boots with idpf faults (always ~19 s in, at the first
queue reconfiguration):

  shutdown as in net-queue (mailbox shut first, no reset):    10 of 10
  same + PF reset after idpf_vc_core_deinit():                 2 of 2
  same + PF reset, then poll PFGEN_RSTAT for completion:       10 of 10
  teardown messages delivered, no reset (IDPF_REMOVE_IN_PROG
  set in idpf_shutdown(), the effect of this patch):           0 of 100

In the third case the serial console shows the reset happening:
PFR_STATE goes from 0x2 to 0x1 within the poll on both functions, and
reading the register mid-reset raises a TLP error on the function, so
the reset is not being lost to the reboot. The device still has the
previous kernel's queues afterwards. The reset the next kernel does at
probe (IDPF_HR_DRV_LOAD) does not clear them either; only the
disable/destroy messages do.

Is a PF reset expected to drop the vport and queue configuration on
your parts? If it is, this looks like a device firmware issue on our
side and I will raise it with the vendor. Either way the driver cannot
rely on it here.

> If there is some clean way to shortcut the MBX on shutdown then I guess
> it would be acceptable, but I don't know what a "safe" timeout would be.
> As you can see the timeouts are already quite long, so you could
> potentially still bail out on a working CP that just so happens to be
> busy on the replies.
>
> Also, consider the case where a reset on the PF will kill the MBX for
> the VFs associated with it, so a shutdown on such a VF will always end
> up timing out, since the VF reset is a message to the FW.

Understood. Given the above, some mailbox traffic on shutdown seems
unavoidable if the stale queues are to go away. What I would propose for
v2:

  - keep the vport teardown on shutdown, but give those transactions
    a short shutdown-only timeout, and stop at the first timeout
    instead of waiting on every remaining message, so a dead CP costs
    one timeout rather than several minutes;
  - skip it on a VF, where the PF/CP owns the VF's resources and the
    mailbox may already be gone;
  - drop idpf_is_reset_detected() as you suggested, and drop patch 2.

A busy CP that misses the short timeout leaves us where net-queue is
today, which is no worse than now. Would that be acceptable?

Thanks,
Tian Xun
