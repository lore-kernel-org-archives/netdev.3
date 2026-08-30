Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F44A2D0602
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788105755; cv=pass; b=MJGBOFPdcCS2t3Y2TCZXEYvocLvGoHTArmNdMLtTwuL+Un6zuFD/jXIuJpHhCOra2+aw8+vpJJeIRd18gvtgPH9wLLsPdYzAAXsyhHkM0PrU3yWtkNBh2hxnW3GroJF1AMBQ3ZGa3eXodGw7NTjrrNq9RGmj41zVySQFMmPS3CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788105755; c=relaxed/simple;
	bh=hkFSKp9oVacHTGDBWJxUwTAVV4UuPLPy+VZKETQ9C7w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DDEzqEfPu9KDogSu3fXRbAputFfojOE3gaXtCox4/eL2Cfa1tL8t4RppUrThQUhqDUnVZP6E1kHT5twvD54rxHEjMFZiy6Hv2oRqRAbjlLzWoxtIYYApW973uqb0r0U9Yn9S6RBQc6WkrMkYknCKbf/R1z6USZuLvOFNn4ttyBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Dyr0qRjb; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Dyr0qRjb"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-854f8068301so1564870b3a.0
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 09:02:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788105753; cv=none;
        d=google.com; s=arc-20260327;
        b=AH3KoqLzG5n14h3U1xjlv4ktsbCCxluJdo8hNC/+4sR4+W1UtQm0C5MwaSaE2GRk/G
         wTB44wdtgExY2WJmcJ556nbfVSDjYydSnLt5r2AII0zG3TbFZHE4l1qxCiUb5SQr8gss
         osvGKAF1lfPZf6LLqbBcsBxH0pus3KQzpIewDPEsMSVhvigh0iRFnbELwYC5KbI+LtTs
         0wI1TtcV4zwnXR9eJDiUyk7URlqDnoAWKtQzH0he7uiGSNzzMYqu6izsxxEemhkPzUxs
         Ns0JNR+OYLkdZqSIoWMFjRxGYFsab3ujZ6KMTZmWoGvR9cdoiyiMildQElbehEHvzLdM
         XOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=hkFSKp9oVacHTGDBWJxUwTAVV4UuPLPy+VZKETQ9C7w=;
        fh=z2bigwwvDuGHx5IkwORw/GGvkkr9t3qLvYNAG2eNP4w=;
        b=GX4CrNQyQyYnd46n6n5RCztBrYIfU1i5/7a2gJkzdPaNpPZO+tGaHVa8O0pOwCWUkG
         AO+0KTuXVxsTpbAoHQ5dZ2cmThNQVdYlQ5T+UOLVZdhfZmj3iUNZEcuiGGIpmLC0gSqh
         jxGhoc6Pr08PVFODT47T11rg2OG2N9muL44+z14UpAiWjHGb6MX4DhNl2CF9wP/HWzpp
         XduuijaW/ch08SVAr9uwgje1cl6ZDE4eFHDgO6kNl3+/EKz7zvmGuE9WVEYpweW5cPz8
         v0pca6h4fHPsHcBDqrEsDGTLHSe/Lbc2J9v4069wd7JzuQrAL5U1ro5wp+XiUFiloOx4
         IvVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788105753; x=1788710553; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hkFSKp9oVacHTGDBWJxUwTAVV4UuPLPy+VZKETQ9C7w=;
        b=Dyr0qRjb9SZdq+xAvFuKNFySTOXqEsTWwa6vHHn5aLV3d2n5pE8aWgeZLJ1Q/72ju+
         W75TuWmnJUyjRSWvDzWdcYbvdd4gvm0Em7Z+9Im0yI28im6MMMlU70THgBtXFGMN46k5
         vilH/X0DSA1SVMr7zDOp6epOTRbrps6RkApQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788105753; x=1788710553;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hkFSKp9oVacHTGDBWJxUwTAVV4UuPLPy+VZKETQ9C7w=;
        b=d8J2ZXv2ORMB/lqGm9wqHDhrYfxM/q8jUwnRUyKea+GKsz4izmvbHH62WCStOpjZrh
         MmWh3SvtNXAkLjohbtJ5SUn5jWkkgEBPp7NaZNBS+0aE/tn4BjrD6HeKGwbxzcJLV+Xr
         68FA6ar5D5Xw9IuWdZrz5by+lgHZIH0nA01RHbjhZ/psQWo3eOgMNcClwdBw5NqfP6zX
         uWG/QjPZbmBH8C+ekWZkspToHp0sZ4GJp9kT4ab4UiBpNkmBJMgGeV314r+88cCwwUI0
         8rRY9AroCpodfKJ0WX+au+ttqw/CVT31RYOW/Aahx0bokO2fmA2pEw//2PKRj1fMk2Ra
         wiVQ==
X-Forwarded-Encrypted: i=1; AHgh+RrOcOBcvLYOPiVEUKV9yiKc3PWOcJQ+/OBGmlO2JZTmFGPU4RhiBhIg/dTkez5CgX8q1sPHHwc=@vger.kernel.org
X-Gm-Message-State: AFuF++lFqms3IWzEd8IZsL9B/M2DDfwT8ArvyWyFPWM4sPrUra23pUoy
	uVUgKVaR6h41XznvqKeCDdXDmpjxSVXnDEzejFPxXPHeGXlqTctBZTsZ+IiDbLTBv09DeCb6Il+
	i7nLoHPwN+H7o4xmwm6+a1JuPHN0PSUkyYsZvBltx
X-Gm-Gg: AR+sD11yMnAcKPjh2LnAwu8HDbDKVyg4EWHnDBKZdodQ9ppgen7qf17vCvd1ibnQV71
	SQrjchi3r+rQaUTBypEZ4MucpZpTnI1bTInPrvFxOwxYpHDx5guVyHiRNsx9MEXvbrF2LIy2U2F
	2n3usXj7cobGWBL8GNSoSAOzQDNvGdwImqRO69gJf3Xks5fO3+DavYVADK0mH+ada/fkoVgjlrg
	6SXEoKTFKE9CDoQfoGr8m9QqMrxBbUA+fAthaLrdqUGJOpKvRexY2wTowf+fp0ZeB0e/B9bigrm
	WxWVrkTR+cWx/4Pk+cZUp6667TnOBU15sSyplK319fdU8Q4PB1e+B8nYsD1XbwWxBiffKqvWmJn
	Xv8gy6T1b/0lGWES3+NsyKkY=
X-Received: by 2002:a05:6a00:600d:b0:847:99bb:b6d0 with SMTP id
 d2e1a72fcca58-8562a5e3efemr38027628b3a.15.1788105752724; Sun, 30 Aug 2026
 09:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 30 Aug 2026 12:02:21 -0400
X-Gm-Features: AcwNN1Wxv6gXynlXZkdqGz-4906GQiAiYs7nZg-3uFADudj72zWuR5esMvfbi0w
Message-ID: <CAM0EoM=usXOM0EuA2VVjLq1N_xbBDAd3jOPXd6hjaGO-tvFGVg@mail.gmail.com>
Subject: 0x1A: All conference material available now
To: people <people@netdevconf.info>
Cc: program-committee@netdevconf.info, Christie Geldart <christie@ambedia.com>, 
	Kimberley Jeffries <kimberleyjeffries@gmail.com>, PJ Waskiewicz <pjwaskiewicz@gmail.com>, 
	Stefano Salsano <stefano.salsano@uniroma2.it>, Lael Santos <lael.nasan@gmail.com>, LWN <lwn@lwn.net>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

All materials for netdevconf 0x1A now out. Visit:
https://netdevconf.info/0x1A/pages/sessions.html

Enjoy!

cheers,
jamal
