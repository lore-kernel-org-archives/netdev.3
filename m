Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C4F3A2E3F
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087455; cv=none; b=kyPY4TaaZ7wgQvxZXFYO4LMYD8kSq7JklYM5073aX8lBFcS50lvV/H3cBEXVbFRk6IYl9rNn8r4YPI5za/qNppJbO9YUJp6spdnHUSY2E5v7zA4El+bIjrlcZRIJz9XSGkhGNJHH0Z1Gx/2jt2FhK7TrkZIPbZ7X5QavhcHEzow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087455; c=relaxed/simple;
	bh=odVzWdwRMk49vB2c3FmIJ3Hae/AVLuEBoTY80YDJQ1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDErYwDopbg5Q84PfeCpqXVjxzzEQpVukZHKRVyanbfX7Q076hNZgbq/FWrW3Xtx7qNReKu54FQCIW1kpGdUWkf2c1l2aeBBo4UVEbVLIeCbeBGEhv/0zIfWWGVAWJL1MfbkdpsroZR7cf93RGpt6+JrbnzhF4TaegLvIWD4nso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtLUFPFJ; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtLUFPFJ"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff17443dso44732831fa.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790087452; x=1790692252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oeDp1cvkbE/ujJ++BUYIsVEpjJJJGQFOULTuibn73Ds=;
        b=MtLUFPFJWnheeHiNFJUR8IPVtukfaKXbGl77oRu3l8Jcw1TuiFxgT9DP/tsyTW7D6b
         jK7eY1Z3YBwBACBHcpkcBKcldldxZ9WDCzohQG1rDEc/QoIIeR+f1IOp6jmXpNqsSrU3
         zs/o0bfw0K1uowIGIlYWRC7qqUxxIRQnh3ra1nMWp/S+n3iQbHeR18KuHVKs1NrM9a25
         cl6zU/sN6eVkDSS9ma5+a6iRE+bJWj49N4+BpoACaioYc7IWPZ0vVE7WGUQa0qE5qGlN
         HOL5rGcN/A9+zk9OB7DYcbx2tj17GXNY7Mek/44EgWNE8NvoFBqe3KefWu4+Plb+6lBH
         Lu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790087452; x=1790692252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oeDp1cvkbE/ujJ++BUYIsVEpjJJJGQFOULTuibn73Ds=;
        b=HJiyvMh+enoPROPrSFLVbIK6kVDNM+x++iFXl0kUpnaSywvw2AacBLgu+su3ABv/lB
         hNxcocTk01qZRFggn1rwaFGyuEXaldCnwPgsi02B4tvAcGDCBenNbPBizecv7exASC1L
         7U7li4l5jy2QARJX4mFqpXN6kCMxBqzCLEYj968RQYlN+uBtgvV4lqnulpCvA23nV1q3
         Ldq+a1FGSXJo3GTljHVjj/gJQDd5Di8zMwDY9pGLkigbmr0ld63W1ihB3F4d5LtoInU2
         XQIf3jlkykKTg0Oir07BR/MSMdHSymeNTqk3gudcael/uAUn+sUZFkH1D8LknYynvAhw
         is6g==
X-Gm-Message-State: AFuF++n8uIYXpHBUQ0AQz2cIyO7s2YHy7uCHhhOW0IFUyxt0/OxClhOK
	LV9tEUt0e2iO98V9Ns7skx8dXj9HvI4MUkw8x/HNzzrMc70lIVp5r2/7vJ2MgOwX
X-Gm-Gg: AYBFou2syAdZCmivX32XUNK34llDOm33DOy+e0Ol3hRcc3D+ANIx37m1UKaZVZLva5L
	iqZIsGRG53vbFAGpITb2TXL975ZvxiUk7clcaXBqC7iO078eGxKYQq20l33iQATndg78GucfNCI
	qf+z3gRQYUYNJV5KrOdAg/BcJaqpxfai5ncxwVfXIs3CdZr/TeixZo1/e1WgPXzuf8Rcw9jc73c
	Kwuo5rLO+QyqrDHtuK/C/DafNPZlAx5fofdZg8KU8kOHhrvpc44CG8eeKii2H76nhJDlyzhPbo/
	ia4JXS3tuJsxrd7+D/XSWH7YGVLxEu0zhoHwExw62FHd2+MEa47SgRdcaKh/pUir1XjbwOM5czn
	HMQ0eyNrDXEiSohbjP4wulg8BsN5U4ENaDlJeeGbSago1j4TXyr1mKi0bNqPs2i45uBWraB7NlI
	fjS7e7yhYA70zuThMNTrnYN/SuwjmBWYpbM/2rfM8P448pyRhiW/zfxvQNNffRp8qUOVfC4lCTx
	NO0a7/OCQJOCKgGBAgaviIfvNkF6vuWn3xAnWqa
X-Received: by 2002:a05:6512:10cb:b0:5b8:bc5e:b57f with SMTP id 2adb3069b0e04-5b8c1956236mr4732417e87.55.1790087451597;
        Tue, 22 Sep 2026 07:30:51 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d46ed87csm583118e87.79.2026.09.22.07.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:30:51 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: Re: [PATCH net-next v15 3/4] ptp: ocp: add TAP CPLD access for ADVA TimeCard X1
Date: Tue, 22 Sep 2026 17:30:49 +0300
Message-ID: <20260922143049.58545-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <178991648135.2160803.1131127618501750446@kernel.org>
References: <178991648135.2160803.1131127618501750446@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 15:01:21 +0000 netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.

All five are fair and all five are fixed.  The series is already applied
to net-next, so this is answered with an incremental series rather than a
respin; no "pw-bot: cr".

  https://lore.kernel.org/netdev/20260922142829.57740-1-maimon.sagi@gmail.com/T/#u

> [High] adva_x1_bus_release() drops the i2c root-adapter lock and forgets
> the claim even when adva_x1_mblaze_release() returned -ETIMEDOUT

The consequence you spell out is the part I had not thought through:
ptp_ocp_read_eeprom() stores what it reads without validating it, and
those values go out over the unprivileged info path.

Unlocking unconditionally stays - keeping the root lock after the firmware
has stopped answering would wedge every other user of the controller with
no way back - but the driver now records that the routing is unknown and
refuses to cache an EEPROM read while it is, so it cannot publish TMC bus
contents as the serial and board id.  A later claim that the firmware
grants clears it.

This does not fence the at24 and nvmem sysfs paths.  Those do not go
through the driver and I do not see a way to gate them from here; the fix
is limited to not publishing the result myself.

> [Medium] The one-shot CPLD ID read is executed from ptp_ocp_sync_work(),
> the driver's 1 Hz in-sync status poller.

Agreed, including the unbind and shutdown consequence - ptp_ocp_remove()
is also the .shutdown handler.  The read has its own delayed work now,
queued only on boards with the part and rescheduled only until the
one-shot read settles.

> [Low] On an acquire timeout the MicroBlaze hand-back handshake is
> executed twice

Fixed.  The acquire path no longer does its own hand-back, since the claim
already calls the release path for that error.

> [Low] adva_x1_bus_claim() returns -ENODEV when i2c_get_adapter() finds
> nothing for the cached number, without clearing bp->cpld_i2c_adap_nr.

Correct, and the comment there claiming the number is forgotten was only
true for the mismatched-adapter case.  Both paths go through one helper
now.  A newly cached adapter also re-arms the one-shot read, which
otherwise stayed latched for the rest of the binding.

> [Low] The new struct ptp_ocp member comments overstate the locking

Yes.  The design is that the writers are serialised and the readers
re-validate what they got, which is not what the comments said.  Reworded,
and the cpld_id_tried stores are marked to match its unlocked readers.

The series is tested on an ADVA TimeCard X1.  None of it changes what the
driver puts on the I2C wire - the ISP command sequence, the frame contents
and the arbitration timing are untouched.

Thanks for the review,
Sagi
