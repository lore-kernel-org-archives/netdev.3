Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB165353EC0
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789525058; cv=pass; b=NMN3nExpdAQCpCpf68bS/9daxogxdwEkLGMQK1Mi1HGYv2MP574nVcuSLtx2LNwaQbA0BIa9gUISN631MTl9Thm8OLpv5pXBrVTMDiR/N35vlSlL4aLOw7YMgis3KEeENpLUlP9MI93WiqEoib8BpyXxWCitr4MqpRYZQMNJDs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789525058; c=relaxed/simple;
	bh=54qaMNvX84LihabUIKKX9MFlFiugZNCJrolAMMRbI6E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pBUgE6jq1sbXxd4WU8u+krSMlX8b5o/a3WgWtd7rlPd+Drq3LgmihDLdH1CWu65D0h6w2cYPwzIUHzgiVo8cWEEjyLaiXowObjW6dNAy9kIYOQxqzVND3lZSuccCIgaCDagmQAV0ongTrzHpjvsm++X/RhXlHAR22zI+dUw0Uyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz2dN5tU; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz2dN5tU"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60590a85cso910486a12.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 19:17:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789525053; cv=none;
        d=google.com; s=arc-20260327;
        b=q98dcfD4PnRyJfrQ066uTovWpyQXPpvfr63S/ukjjildxSy1dDxG5U7pgB5NGS1ALD
         ijfvFMMIKQ+dncNKjiDaPyjIQekWQEp4436fKAYLLBSxlECRJdBbNn3B3OLFdpvfx6VX
         hjZKTOVK45qQlXgGj8F8s2U6V1XFR6sTDi4YeY4CDESOgej9FzfIskfEbO7HmsIiBczK
         fSjH2lzBb0zufLg/qyJ0RmH902gnJVKJbsPy6b3iNvPntT91A2qvdYWbJ+37urGcKA+k
         4Bef1auuiAA4jX2W72V5JzWGec3Pd4bfvvUed2zbgpn7l7zAE2CqLfyZTQ8wqWs4JEdf
         O5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=54qaMNvX84LihabUIKKX9MFlFiugZNCJrolAMMRbI6E=;
        fh=tpSEDLA8mUhBrsl7MaGGLstJr7vJOCRMKrwxK9Ke7b8=;
        b=osTdLRfoY4IJz7xxlDM6UXDtdMQVXQ+uBxqAHOnZukHn1x4pqfE5u7aplWtpJPq9Gg
         rcTkAWLdo4cgBA926MiLCImdYDHog9SWmY1Q34Xs5ZoAl+tdohuYPXLnrprS4fb0H9LY
         JnrNrlc2RtDdL0R6rTZavFORpKYZH3Xwth1cTpiydtaAXA6Usf+E9iw4sdSRvyx35XBf
         BqKQmmAy7lrl6Cm6lcxg8I9odaHYl2ds3/0y8098rNeu//M0gouJZo2ETSRO0lbhPmSx
         AdHftaBsy7xfD4Z0neM8e+veAla/5vjbNPeBAl64N3fy2CFAxvvZj2jRCgreMpi1pWCb
         Z/gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789525053; x=1790129853; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=54qaMNvX84LihabUIKKX9MFlFiugZNCJrolAMMRbI6E=;
        b=Oz2dN5tUqi4OcOZk/UFTk+Z+ZadbyGfwHoSXrfRbAPEr28/DW2BZkM69EzvlREzwmN
         SKPnaZMbFq2It+ycXcqRd/NAOypJHwX0q3hscWShwUrJqRaXAn62kQD3fVmM+A4Tg8iD
         CZRFirKDJcGklXY+VRnQtDtZ2oZ6xmj0GKqVWfrq+9Z5eZzOOO8rxCPGkRliy5JoOmge
         uZ0DDGStjCF/goau/LVBjlEltuO10nB+085cRWrnmdFsYDMc5y+zHhdP26EJhM6U1HWI
         ZJNVQd+9wekZOwbny3BufBoRdI+0pZJP3Hy1PtnKM+3gSDZyTt7ckrp/PTo+5pAKXcH1
         +qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789525053; x=1790129853;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=54qaMNvX84LihabUIKKX9MFlFiugZNCJrolAMMRbI6E=;
        b=tAcwim4B8EpkXpmpbURQINhH/fGYhL03C/Wgk8K7hVQlUBfkOU3xJfKshb3kk+6wb2
         yxqHYfa5ndBTxFmdgm9PzxHXOAsXuqVimlQ4IyNJwB94vE0iUrTRp4oUwUFL/Pm2J7ye
         HW8GxHmMHvZQSkPhu5kLRqoHS/8Yb8WMzr9LYakGdoH6CY2DZOswyMFzS9MFb56FXpXV
         sboru7EUeEVK2Zo5+o7zGEoBrDJQH3QQyE3ZyPXHJAs45pIAduERjq3LR7FGL32RMNNv
         KGUwFFRil5C1/dsMZ+HmoVeFdQmxPHpZdRaC/+dw6AP95yPTnd1fiaTOCvSivR4qMGv1
         fkog==
X-Forwarded-Encrypted: i=1; AKwUvByHFZFsT7FfWrVZHk8TUa3dnMUD4gAc443GkzzWuAjctbvOcJl39qEcjSMVHKLueh2vM5bXlGg=@vger.kernel.org
X-Gm-Message-State: AFuF++mVxwQlH8flv7rcziSRSTgTgGS7S/CwqXgbtl/pnygc+d6Yh+QP
	7BkTbn31o+NAlpC1IwgBlWW2Yd66Sw+zjlpU4hrnsUvyj31f9REAVj19kTdL9d1Tkj4P4h+I00F
	dlagjG3lVolQVwKFI5FPj5vuFf0CcphE=
X-Gm-Gg: AYBFou2Jb3rRv+QUgnpyqm04jgzWGD+gHFMR19QUEkJqjmeYaq7OmCw+Z6DxQkU7Ehr
	uqr4EenZoaXB3/8utpW6sHUxkOie/KOgBTb3u+eqhNd2gH6imqM1bUI7eyDREz5sVqy+jT/IM0C
	eoQW4tVyFJN4hgu7FLLP5eWVsMyH5xkr1vH+swh0oY8UoI1lXvsT2EFwOdym3umVI7mRrXMz3+q
	ARp4wtTJGG8om7e8+I0YRjtsMLs1NFdx8BsjsmIUxmMQx3JjIQhwkf5Vffahs3s5qiS9VO1f1xe
	baYZTvAFJfg3SqeHZ2quhsbytQbKRNXEGPZjlCBz7rs7m1wsI0rcfJperQ==
X-Received: by 2002:a17:907:9309:b0:c29:60c1:7e55 with SMTP id
 a640c23a62f3a-c29e523d53dmr34794466b.12.1789525053165; Tue, 15 Sep 2026
 19:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kenny Hsieh <kenny111575@gmail.com>
Date: Wed, 16 Sep 2026 10:17:22 +0800
X-Gm-Features: AcwNN1XxfOvvKrV2F5QzPoOkWrOGLBKZFdGKKdmcyH8Ac85pDEwI-499SN0DF1o
Message-ID: <CAKUyoTvQbO=6ed1p3iC_n9Jm9gSTwtHm7_NRAiJmuaNaKjuOvA@mail.gmail.com>
Subject: i2c: sysfs interface to enable MCTP on mux child busses
To: andi.shyti@kernel.org, peda@lysator.liu.se, linux-i2c@vger.kernel.org
Cc: matt@codeconstruct.com.au, jk@codeconstruct.com.au, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andi, Peter

I would like to gauge whether a small sysfs attribute on i2c adapters
would be acceptable before writing code.

MCTP over I2C (drivers/net/mctp/mctp-i2c.c) creates one netdev per I2C
bus that carries MCTP, and which busses those are is declared by an
'mctp-controller' property in the devicetree. We ship one firmware
image across several chassis whose I2C topologies differ, so we
describe only the root busses in the devicetree and instantiate the
muxes at runtime over the i2c sysfs interface.

What we would like is a writable attribute on adapters below an
mctp-i2c-controller root, creating an mctp-i2c netdev when enabled and
removing it when disabled. Entity Manager would enable it on the
channels that need MCTP after instantiating the muxes. The driver side
already exists: mctp_i2c_add_netdev() and its counterpart are what the
i2c bus notifier calls today, so this only adds a second trigger.

Our preference would be for mctp-i2c to add the attribute group itself
with sysfs_create_group() on the adapter's device, leaving
drivers/i2c/ untouched. That does mean one subsystem adding files to
another subsystem's devices, which is why I would rather ask than
assume. Do you have any thoughts or concerns on this, or a shape you
would suggest instead?

(Resending as plain text; the previous copy was rejected by the vger lists.)

Thanks,
Kenny
