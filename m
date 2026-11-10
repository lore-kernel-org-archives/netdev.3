Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322028;
	b=3zgzUsuxWl12k4JaebC3uKRHuc870OPtaBrmdQPHSqxbcy2WNXa8UW1tg7pU+vqEDC1Q
	 Cc+CPTQj1IYtk7LDrkh+Ezv+gCI+KCzJDLGbmLVVZtQOhRl9SV0U17nVzFOkC8sADT/fb
	 nQLHJSzsnwh8xFgpQ8CrBY5dAWq1StrDlC6Hf7O7yoAkiYbG1NXIjSgnLy9T3VbfuRNSE
	 fCk5I6Fv/kfXmtI9dJyIub/P7OcTHRsapUfbyM6Uu9VQT0noDFVulz7kUzFYHnHNzEOo6
	 K+KjWvTo+DLzhcJY3qRTvtD+NCUlduwPpBYbaq0X/UhXfxCRmHJoXIjx73WuJ/9016w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=u1PZcGNMVLtaIMORkcmmsE+I2/Gjn5exPeLtm/VDRh4=;
	b=DEAidpFB+5JmbyfFXxSCiiwImUK62wmsHfWBnG4ksJ99vaNaNnT7l5BzefF/sNhSveVY
	 3aIIMccNRkAlZ0PzdMZbUUHBikBiKMJCCHw9s/jqnBNe00pgtjGDsDIA0LKbs7hrCa3Yy
	 4ZFik04hUd1URnvXxAHsBSPVQ1OzWPSuIfQtrzHc1+p9ZhbVzrtPuo1/3YtggKyTp/ouw
	 ampJOKpr3NV2dzVJObmKwrEk35gcxBUiKoCft5eZP+vasTB4Ym0ha3xF/tgFjEnNdpaan
	 f2z1uFZYBe0c2tgRFYvrp73yV4FP7bJ5fhFXnvQMyzN1sQklsPA1JTLoGlTWizX2H1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=resnulli.us;
	spf=pass smtp.mailfrom=resnulli.us;
	dkim=pass header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=K11eR5At;
	arc=none smtp.remote-ip=209.85.208.169
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F92606A32E
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62F92606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=resnulli.us header.i=@resnulli.us header.a=rsa-sha256 header.s=google header.b=K11eR5At
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3acef9307c7so16781071fa.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli.us; s=google; t=1794322025; x=1794926825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u1PZcGNMVLtaIMORkcmmsE+I2/Gjn5exPeLtm/VDRh4=;
        b=K11eR5Atk2dkZPU0waoGKYbBbbBkLQ4RaA8Y1wtgzCsFXlykCGF4l+MyxX5zOiLkxd
         QNNMtKiAtY5GNpL/oZwTflK6T62jqK5HruVBPkuVd6i1yBjCH6LtKPl/luY0xv78iTby
         enKTJjNDECTRhugI3a3EfWZFdpeCYJaoFS1Qpx/N93rYon5CUAwD3aw8JgwKD7ttuxBD
         CmhRQnm3mGDAKTZoXQY0xooS0hEnFK32YVm34QJ9QwaZfuhmyc4G9nBp2Im3GNfTwNrX
         S9bSTsnlVcL25IEd3hGdldMOTuNRzUeDppK+HRpE1s52LPaqDbSxhqCO/q8B+dfBraCr
         btoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794322025; x=1794926825;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u1PZcGNMVLtaIMORkcmmsE+I2/Gjn5exPeLtm/VDRh4=;
        b=e+I2iNc+zGPN4pMPfZ+5HoCig289ByTXfLfoyMWn9ZCxr53UniVjygVLbENftC4j3w
         dOr2AAcnUCkuXegRHvTn/UQN7bfxfK3n/xQi1l6ChNcxmgvvtUSD/XRdEySykjRMngU0
         B4PvzcCbeDpMytc4/iKfaMvBwFFuDGrGj3IrKNpiS0QV84svEmduhytpDIW3NQaSnhYK
         9rXKTWjXg/xSGNXZxwpUimXwKZbv2GgPKRk+PwxVVthL1JEXGCq34Ttmf2BmKaZ4VWNH
         3176f42cd8i4wODFKJrlrnLhRArJCom/XZ8lA4HIsurO8HfzTbNaTmvxaYP51hZ4HZob
         BuSQ==
X-Gm-Message-State: APuU4Z+aI2a7Pdvz0xg2218LhizrrP0PB5d7dBN5vshrvC4NWGGcp2Sx
	3lDnMSBpE6j5NeCQVwvQs1u4zfjEIajGeIwLVXXwAQgPRdcDaadk9kFXVkwXM4/iEWI=
X-Gm-Gg: AYBFou1GWCGhw/gxLy4UFqUuU+qjl0LL3ole2r9eIRo+y7df5N7a/1/qtH0+EoKNCbN
	90jTrEiTwhfUxUxL3EVjwqJmnudm4Ek7OabgItC+sNVrn/9NtSoTKHUoi4RyiYIGsuC8U5F8eB4
	/pAGCR+EXQdAOJMrVsvk9rFotW1j1H6KRWISC4r+j0lRcN6LxJxEcHO30n4afITYl1pzJa9hMAX
	gGIvLO3ZLTrrs1S5XA20TSJyupYWyRqDmE39OdpH7313ffXKtw5Hq7ODv4KBVtcaK+dw/dgeJL2
	PyNV9rXN3Dxzn+pILgiz/0mt/snuDpuMl53qIbXaC/mszTxL+n4IxcNjtBXVAhe2+iysImebiaq
	S7IADkKJlsGL0X7nb5+zBvvL3KD7HJh2STwa0cFtlHp7lN1MLSajebbu4gnHcSMMbmIcHUc46Qy
	e/bNWjB3oc7cgmZw9+Fy4A0r/aAmFGtHdsR95jCNTUTk4vQOZIe67+Bpd09/L3YGdogHlGNlbcX
	FHTTBmm6fmDR/XZMsx+c7i6DX4/r522MiaxOpOchnVYclIwSRYq80Kj0xwpgjK5k1WpdvLhDu7C
	uSnhs29j+B+COWCwk7XUml3jgfbcMB4prnR/4DXQL8cWW5B9jqc4LnbajMdzNg==
X-Received: by 2002:a05:6512:39cf:b0:5bf:d93d:77ab with SMTP id 2adb3069b0e04-5c156e7af39mr980525e87.14.1794322025251;
        Tue, 10 Nov 2026 06:47:05 -0800 (PST)
Received: from localhost ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157b79f25sm478499e87.8.2026.11.10.06.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:47:04 -0800 (PST)
Date: Tue, 10 Nov 2026 15:47:01 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Michal Schmidt <mschmidt@redhat.com>, edumazet@kernel.org, horms@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org, 
	rdunlap@infradead.org, andrew+netdev@lunn.ch, saeedm@nvidia.com, tariqt@nvidia.com, 
	leon@kernel.org, mbloch@nvidia.com, jacob.e.keller@intel.com, 
	jedrzej.jagielski@intel.com, anzaki@gmail.com, brett.creeley@amd.com, ohartoov@nvidia.com, 
	Petr Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v5 01/15] devlink, mlx5: add init/fini ops for
 shared devlink
Message-ID: <avMuXCHLBdfcT-8v@FV6GYCPJ69>
References: <20261110141534.95614-1-przemyslaw.kitszel@intel.com>
 <20261110141534.95614-2-przemyslaw.kitszel@intel.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110141534.95614-2-przemyslaw.kitszel@intel.com>

Tue, Nov 10, 2026 at 03:07:10PM +0100, przemyslaw.kitszel@intel.com wrote:
>Add .shd_init() and .shd_fini() ops, that will be called for the first
>devlink_shd_get() (to initialize driver's priv data) and on the last
>devlink_shd_put() (to allow for the cleanup). Both ops are optional.
>
>.shd_init() could return an error, which will stop creation of shd
>instance. The initializer also gets an additional, optional param,
>that driver could use for any needs.
>
>devlink_shd_get() now returns ERR_PTR() on failure instead of NULL, so
>the error from .shd_init() reaches the caller. Adjust mlx5, the only
>user, to that and to the new param.
>
>If any of the callbacks will need to get devlink instance, it could
>be accessed by shd_priv_to_devlink().
>
>Both callbacks are called with devl_lock held, .shd_init() before
>devlink is registered, .shd_fini() after it is unregistered.
>
>Next commit will make use of the callbacks, a later one will make use
>also of the additional param.
>
>Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>Acked-by: Tariq Toukan <tariqt@nvidia.com>
>Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
