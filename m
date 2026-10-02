Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1123A83B1
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790976117; cv=pass; b=Jx+k6/Rc6TJ2CJtbWBXd3ftEEJBhbY+zka8NhVi15qiqQRRic7stvKRxDCjAMObQ7iJc3TaJrDbR5s430/756xPozVtXKPKU+CJJ1vsYEl5bbjdWYKrrm4VGIeWMe0JubbqIgzfXFLh+YdE53pqrIu/rk0xPrDhJMESQ6u0bb6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790976117; c=relaxed/simple;
	bh=dt/JHHnpsow7Nz/YnPPkJ1IOyT2gnfClRpcVgwgh27s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpLpAq2Rjr+J48UR0blRMC+iaFEvIVZPXYoFEeXqZHt4afnf67FC9ew+p5qeZR4ZdPBeNSU1WKtB4hjzrvdbe/PSCq0ijSeh9wy4zL7a95edXq576rtqJyAj5EsCpCwQtqPBFDCwOOWpP93LxjTcWSJlzcRkFdFTu3srYIejAso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuIrGof7; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuIrGof7"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6ab006eb282so1739518a12.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 14:21:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790976115; cv=none;
        d=google.com; s=arc-20260327;
        b=VE9n5b7X9LgMIVM0ll3sMI4Otk6GjXfz70UZEqma6KjA/F6t+erOytC/f75Bs8porV
         UIrmNA9pN7Cis+TWXTMz0/Ss9K8wFoi1/Ryfy6ePgzuSpsKDtjPfxtfACEDDY4gI40sE
         oC9nS4Rq28Le/46dCLehyiDad4Uux9G9NOFBqGEBG4r4x8d2capHbdfLX869OV66xADG
         qP3y6v0Mq0m81ZDpqJ6DLdjZGzjzfzp9nPTaHdvpGw7leCnR7koCdLSzmYu34dzVDvLl
         WgV6/8vMbjoz/0SHOT044N3zVjy80R2hd5sWDYlgW62NBWdKvq2yrX+sgBspmuQnkYnp
         C3PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WDdpp21aI+ctxbQenapk5I3KWOO2WbNlJ3B77rRrSeU=;
        fh=SeyHHaWMHrYed6tJnYzJaFNBNlgQDAuU44gfMuP86WA=;
        b=gImQ2++iAwwCgPLD3T+K5SN/foJtzPcJNdjh8ItCd3+vLsGXKWEfNVxZruh/dVahe5
         mtDoR1SHfpSu9UDxPwMIcjZxmCc2z6LEJv2XvfCPmkckr2YBImkx5BZX3WnNvXPnRpz2
         3BU7L8KhslQ7JbnE/kIDWdLpKaUTMlZxBdPs5PtUuSCkuvc8Ibm0H2dZ4OACRFRewDWI
         JU8LDmGqHVAnnPdqbOxecHmz6fAOPh/DMX9RTmwzZH+6IfRlH1E+y789gIj3ZuGmXVEK
         5Fz4X1tZzuq28HH51CAzkysTmcpPdBqq4NT1CrnD9f5BEsYSf90LiGSAXk7ATrmHXSbG
         nM3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790976115; x=1791580915; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WDdpp21aI+ctxbQenapk5I3KWOO2WbNlJ3B77rRrSeU=;
        b=QuIrGof7dNHfmtBl8tej2CxK+RLusdCzOoAB9eibjVnpc84OzzXXdb81/Tckkj/y3c
         y46cUx2S++dC0SbaeIt8KeqZXHLGoxv4zwLhKYffQ/rpiKXmDBW+iVrQTWwkCCQ+mnJu
         ezFcEmvpq5HPcWpmX24K7TY7hB2Tn4I22lxrf6JTC6HgDcPK9TpcDeWwISgRloqpSpYn
         dCAiDLcD76B3ajnJvePWbonAxLuwQxuObIgeNE663aZbHqBHCSI4tE4CMPRJuc9Avgan
         UHiCQVKOJYNfLszWJBdbtuigGU4Uhs5tFK4wYUcLaVtQc5TKWFORxS7jUXCCxmhMpXkg
         a2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790976115; x=1791580915;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WDdpp21aI+ctxbQenapk5I3KWOO2WbNlJ3B77rRrSeU=;
        b=wO5494b7Uolh/1ivnOU8zc0lKvl52m3wt/h69n3Lk3skiFBxAC2C4AnZRl7Uv+IVLe
         Jizki9rZOoIH3HA8Fm9q71N2Be/6EOzjF++W9xFLpS1RV5GzxmIRwA1wwfh+j/oOqfvm
         gUIa3jR+kRR7jJXPAYVS8310bYrdtthokXSCi3Q8eHUuMFb1a395MlNLPcWV1VkX0SF2
         zh3qQKA0RBRsATeoFh9fRqF6Dl9NSbWlqcXVrlrxaRbWk0ZXZYt6bNH6MWrvdK6nulO+
         HPpyDaZWDY5Y0ykYMYHq+BJblnlGMiBMjm1165GQ6YWXdVIwVFe9Y1ZLTyavviM1wJEd
         R0EA==
X-Forwarded-Encrypted: i=1; AKwUvBw1zpM0obUW9X4EorpxVxJ8QLC22VQFFQLRlg+aGm3RuULS9yqA6+FgbfBRXLaBdhSHiLifch8=@vger.kernel.org
X-Gm-Message-State: AFuF++ljpW1B8jg3qu620u+VkwIlOOLXIXA6b4VOFYsCieXWyTcNp5lz
	zpRbSsC4AK6u/uqkZZeik3IQPJgHPSyfB6H08hy6U5SQ6Dz7txbLj7j2z1R+Xp59L2M2VGbJRCA
	9jGHcqUTpOWYD5AbCkj0arjgqP9L3i/s=
X-Gm-Gg: AYBFou2Z/S0AVg9sFLc4xSCVsvqMKgDHYBnDsCmh7U+wEgO+jFD5p38YYv5iXshZFu6
	q4BrDjeuwGigjEhFwpM9vKujvux40AH1SfVflxJuMUAv4QxFhQNpmmJUq2D59AZjCeRt9dY7AFc
	qCzhjZahhA3Kh5ZC0lvdTZ2EkjJFlwQuT4B52DNxlBEZ8w++9BabWAMzPdach8tMDHsTy9cdECC
	VtRGLZJw3cks7YL7/lciRpkOtGKVOAZfFDgaV41VSdVh/5xDRREnysNm8Y/VkXGUE9jiHPbmNhg
	7VqnmYG7Vkth4Tb1xilgc9bXwMq0dwTta/b+Mp8Kl/5ueFBVPZNig4M=
X-Received: by 2002:a17:907:d26:b0:c2e:4b90:3c55 with SMTP id
 a640c23a62f3a-c2e6e9ca0f3mr36979866b.5.1790976114526; Fri, 02 Oct 2026
 14:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
 <179063700944.31693.1912265472568249345@kernel.org> <SA0PR05MB7323DC46F887920C5983712A8B8C2@SA0PR05MB7323.namprd05.prod.outlook.com>
 <IA3PR05MB22078467309FA5DFF33EF712488B892@IA3PR05MB220784.namprd05.prod.outlook.com>
In-Reply-To: <IA3PR05MB22078467309FA5DFF33EF712488B892@IA3PR05MB220784.namprd05.prod.outlook.com>
From: David Butler <croepha@gmail.com>
Date: Fri, 2 Oct 2026 16:21:43 -0500
X-Gm-Features: AclHuK-bTq4fqyK8Qp-XM5-ziraSEErIVduveu93L7mj7fPsxkJ5cHtqelJYXag
Message-ID: <CANm61jeKyX=+ChYyw_TRGcCS7mRxDYU3aaqht-mjMN=+djbyeQ@mail.gmail.com>
Subject: Re: Fw: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates
 2026-09-28 (idpf, ice, iavf)
To: netdev-bot+sinfo@kernel.org, anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com, 
	edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	emil.s.tantilov@intel.com, luoxuanqiang@kylinos.cn, 
	bryan.fraschetti@canonical.com, tristan@talencesecurity.com, 
	tomasz.lichwala@linux.intel.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"

Answers inline for :
iavf: cap advertised max_pkt_size at the single-buffer HW limit
> How the issue was discovered
Found in the field, in a real production environment, and reproduced in lab.

> Whether the issue was actually triggered, or is only theoretical. If it was triggered please include the symptoms, like the stack trace or error messages.
The issue was actually triggered.  VM and/or hypervisor can lose all
NIC functionality, VM may stall or crash.

esxi icen logs may include the following:

        icen_ConfigureTxQueue: VSI 8: Failed to set LAN Tx queue
context for absolute Tx queue 64, Error: ICE_ERR_PARAM
        indrv_SendMsgToVf: VF 0: Failed opcode 6, Error -5

kernel messages may include the following:

        iavf 0000:03:00.0: PF returned error -5 (IAVF_ERR_PARAM) to
our request 6
        iavf 0000:03:00.0 ethX: NETDEV WATCHDOG: transmit queue N timed out

> What hardware the change was tested on. For driver fixes please mention the device (and if relevant firmware version) used for testing, or say that the change was not tested on real hardware.

Key hardware for reproduction is E810 NIC, running on esxi (icen) with
SR-IOV enabled.

E810 NVM revisions: 3.00, 4.51
icen versions: 1.14.2.0, 2.3.3.0

>The evaluation is done by an LLM so it may be wrong, if you think that is the case please reply and explain.
This information was covered comprehensively in the commit messages,
but happy to repeat here.
