Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CC33AB460
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370615; cv=none; b=fVNwFf+Buw2/IeI5h2N3IZzMBRKbNGX2445TXc0j5HDpd7OlBzR8+tUeaPkZxB0c9nnmza5Dlb6rnNSBmkHYN67n2kLMFAx0GRsK6oFYDiJl3z5rvlv5gsS+UYInK4CinSZyb3AxD/TnQcweloVRpp6q1u2yG6+uh2bcXEuBBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370615; c=relaxed/simple;
	bh=m8i10BB28CjHEmfJwnAq4MCAOVPV5YopFoXFNKsfgVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kX0iD8SatzP7mJBumK2jrQSn6ylGxRSRKS9u0+GAa/CIymuG9o0Aq6pXNi88WXA5Oz5ysH15jVX88WWwrnuAThflEjAz4UDn7BR6lvnuZ2WSqk4owS0Y2wwbWzKj8908r4WT2nEWAGEhsQdy8y6NxLNC3P1fbpLZH5Q1NVdt54c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRE1RsiP; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRE1RsiP"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so9461045e9.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 00:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789370612; x=1789975412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xCHW7Z1dfaNVRjdSB69yNYP7qooRBP1sf8/Vamo03g0=;
        b=FRE1RsiPbOQ4XAUZYo1R7zV1d7ZE/1SxzStDJObuy7gK2Hqe7NRZMyExBMQFfRVOPL
         rgeJFliEpdjmOvQIhM1ocn8msRlA5dyDDMIwxMS4NTatSMids6Onp9P7hYXJrX3jfJJJ
         ji2j1GG8Rd8XSwplRD7lnfsmoqvkXKI1AAeLRvURVHTe0nrYzci4S5tJXdLnQe7SN1Y3
         W3E5wu7ykr9ffBk2C1YH4/QBMiYERfqBoX2liLqnJZEvB7IZN6VPquwHIN8r5IGauO8T
         jqUUke0Tmx0+bNoB+vieamJYVIVR3T6vpe5tCrz17FaVAqX5sBz6F4jannyGxtz9s0+J
         VgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789370612; x=1789975412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xCHW7Z1dfaNVRjdSB69yNYP7qooRBP1sf8/Vamo03g0=;
        b=VMYrf6RF7YXp6PoYlMi9c+1LatBFz1krbDJk0Xk6z3cIAv8SzpcXE+CTrj/rVPMVkY
         Gw1i4eebWP4DAu29JPgWG5jnoSevlvhOB59PQgaUwY/HppevROOVX61Dn/TBu27c574z
         QPdqBvrbIXlxIxKspkwO+VTBtjFLwP25+29fmKXXrU8EMNnvj3OEHT3G9mGJg4672wzo
         Vq+ay/uqerthmIKv4/Qm/8x4AVFZ9TSMMQr7b8sYChpfwhAqm2rf8y0bkC/m4mkAwX0R
         OvObVf9TQQKppRRzRwXhtg2CZPWr+bAeVo9PmoXcIRIXoHExJXevVSxPdS1xSAdlyfza
         kAIg==
X-Forwarded-Encrypted: i=1; AKwUvBzpYzAZEGwSTTESkgsjQF6mZk0M4VsXvBBxfOkWHnxog92MgpjrXjOXnKBi/P+eTaVfkoya3ug=@vger.kernel.org
X-Gm-Message-State: AFuF++kmuCEtcXi8vTCwxKB3gfRPD3F/Fy0puJoMnNnuljd6RBgNxvEi
	VsMs9CofNIOPIhwfhjwieUjsKCsSxgRgbHVf8v3hynaUOX95A60A1lEa
X-Gm-Gg: AYBFou1QeDkFIP/vDUw9V/+fO+CPQhH7FREj/KdLmPA02/cSQKHknalw+diviZHk+4o
	oY6ODtovet3+0+GusYutn+95Ki/IVCLshKsqN3E7TEgndGaHWPC6qMEhod98I7xoAAfC8wmrKMR
	LAtvw6a1n/Mv4XkmbIsVh81iMVBQh0UMI8swLqWfmQYGjfPYfDVCVei6RHOYEip4QQUOP2IJ+7R
	hrK9cqw5vc7lklumiA0KlGBRc5txQCO30+Wsuok9fiIzXcv9a4oAtmf/BJIOT045XRVw6BUJuJ8
	BpkBSIe9t11uK3jN+5u4cF2NYr2d8XZLghgsCWuw/bEOSda1YjnJkLPIPdz8PsC+lPfw+YTZXsm
	Z0t0BgtYqi8rmVuzo5bJgaU/Iu8GPCrkEwh/AVQGJWzx59cr6OCkhuXmlAinVxZt87B8esZ8R4p
	wdKkFgyqby3tRCbs87+mOP5QS89+nS2wGy+CobF1P5pvMYOCcPIyFHZPiWPE1xovu4bhJrx90no
	631Vj1P+XqmlPNLOo2O310qhBrkmewkPslRqLvoAsL7XIcAyg0=
X-Received: by 2002:a05:600c:46ce:b0:49c:dca4:94c with SMTP id 5b1f17b1804b1-49e7a6870d9mr21043765e9.13.1789370612080;
        Mon, 14 Sep 2026 00:23:32 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e6f1sm24067664f8f.6.2026.09.14.00.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:23:30 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: Re: [PATCH net-next v13 1/2] ptp: ocp: add TAP CPLD access for ADVA TimeCard X1
Date: Mon, 14 Sep 2026 10:23:28 +0300
Message-ID: <20260914072328.12824-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260911165243.53764253@kernel.org>
References: <20260911165243.53764253@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 11 Sep 2026 16:52:43 -0700 Jakub Kicinski wrote:
> > +               done=<0|1> busy=<0|1> failed=<0|1>  
> 
> I think the sysfs rules are "one value per file"
> We can stretch it a bit and say that this file contains flags
> 
> So format like done or busy or failed or multiple eg "busy failed"
> But the X=[0|1] is too much

Changed for v14.  The file now contains the names of the flags that are
set, space separated, and an empty line when none is:

  # cat cpld_status
  done

  # cat cpld_status     # during programming
  busy

The ABI entry lists the three names and what each means.

> Also I think the AI is right this one commit does too many things.

Split for v14.  The two pre-existing fixes that were buried in it are
separate patches now, with Fixes: tags:

  1/4 ptp: ocp: unregister devlink before detach on probe error
  2/4 ptp: ocp: fix dpll cleanup on probe error
  3/4 ptp: ocp: add TAP CPLD access for ADVA TimeCard X1
  4/4 ptp: ocp: add TAP CPLD flashing via devlink

2/4 is a second bug in the same error path, found while looking at the
first: out_dpll never called dpll_device_unregister(), so a failing
dpll_pin_get() or dpll_pin_register() left the dpll device registered
with a priv pointer into storage devlink_free() releases a few lines
later, and a failing dpll_device_register() leaked the reference
dpll_device_get() had taken.

1 and 2 fix 09eeb3aecc6c, which is in released kernels, but they only
trigger when probe fails, so I did not mark them for stable.  They are in
this series because 3/4 adds a mutex that ptp_ocp_detach() destroys, so
devlink has to be unregistered first.

If you would rather see 3/4 split further - the bus arbitration alone,
then the two read-only interfaces on top - I am happy to do that.

v14 posted at: https://lore.kernel.org/netdev/20260914071531.11640-1-maimon.sagi@gmail.com/T/#u

Thanks for the review,
Sagi
