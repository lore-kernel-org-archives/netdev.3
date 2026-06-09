Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13DC2D7DCF
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 01:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967053; cv=pass; b=tvk8HN7JleeGBLCIbeDBD3zGx7Ck4rIFl/JE4TCOibVjvnC2QdOILWJdSInrUVJsllVdSz/KlsQztBCn2o1HG2JDQ3UfEsVe1rRhCfjcjQuWKWZWOaX8wz8yiglkWd6qonvZMpjNDPgIPiygkpeZWfzgL0dFsaUGVeYTiu04EQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967053; c=relaxed/simple;
	bh=hEUhhWJ5XRKRdTUcEBSkJ2A+TwML/f4AKJDLcMX8/IM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=duHa39p+2A27GfnNRWHIMsveUy5O/6kMQrE6EPD2wdZ3vuBbQ1g0BZ5iwIaweBrgTm24hY2/oq4pVyUKzp5dvAfd6xbdjnqS+7OySYQFB7UyAs5ZmJPMf/WOR66DecfOOv09NSW7HkIdLxbEMCEXzvdz/7ds3Maop+gUgMlHx3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lykfywAX; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lykfywAX"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5176465a4a4so68747941cf.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 18:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780967051; cv=none;
        d=google.com; s=arc-20240605;
        b=DmE5Kl0o0XnrdZJMi7NJ8f8lEXBiu6xE5GJtXnNrItosQwPxyKu0EhqOjVVWWOj7G8
         dam3Ie6lBeywnPDFMVmnHnvRyxtpYw97kV/d2sFp8eQgB93uiB+A3F/4Kj4QmNPD7E4O
         WD26rtpQgJf6HCkAualHl0GK50jEFIGfVjQ7SLYjz6Nr/CVefuc0oqjTlZPXUBRlmiQd
         a0LO3142TF4gnbsRU6Q/RfT/LMWQBuIeO/VL6rrwx5iWjiwFXNUw8AmQIakdnC8PnbDy
         R1JWHUbK2f1VNuurSWpCMAHepi8Gshzcg0fawmTTmmT7Hp7BqaVVZO4Yw6sQM5Bf9XXf
         fNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hEUhhWJ5XRKRdTUcEBSkJ2A+TwML/f4AKJDLcMX8/IM=;
        fh=/ftA4ztmv3ij2KZhAT5wITeSN5GEb2e5M2nQsudJgEY=;
        b=isoKzA72RgiNgNykiuWW5689TldVV27x9XnSYZOGSePFY1ZFDwgEg+odCxV9MOsIQU
         SCHUIrpfE4uYH9m5vH7yvU/VgtSlUWZWDRZzjuT/kQNVkBmwNs6MPsEAienK/D+U/EHY
         nWZo713daz8C5abSz6kEbqYfNUeMlmNzguMJNEpRaazJTSXvJL7RI2KZhawIsGCp0aIv
         g+EemTkc7DreTq13bimUL3FvyGc+kVZIKY4Y/y66cbM71HCaOQAAmeP0gcfHf/HmCuCm
         oqb01Z36DQSAV/NW5ZMNi7qwobE1I26SBtRFWQ/BNM7dQGnaXv70Be6iJoYExoMnTtqr
         UZRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780967051; x=1781571851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEUhhWJ5XRKRdTUcEBSkJ2A+TwML/f4AKJDLcMX8/IM=;
        b=lykfywAXbeiHahm7GTYXJRN+BshKB9fF6jnzV+oA26A0siZ87B48l2h5Uc0fBUB3jq
         9XyF1b+uldbe2TNpMpSp7ccBV0Ve6LMjWI+2i/H5KQudhn7Pgl8PMUzKWPJGYfY5Qm9Y
         pnUkGmMI2io+Fq/b1Csbbs2nFbbzlv7uD51na5wbz22D5UVI8/xx1KL9BA2R0NH0d55f
         ZmPpFaHRmsz2Nrdb2wsKkBF7HZ74WYbJEM84DreLgu5ezVr/x7+SGPJ2gkG+Sp9RDsHw
         JvX6eFOe3GiwagUcVvZPTMkwqUVfWbu9hzQWOGl1xtT34P70mRqJQBA5OEZZ92tW7MED
         S/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780967051; x=1781571851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hEUhhWJ5XRKRdTUcEBSkJ2A+TwML/f4AKJDLcMX8/IM=;
        b=W0pVH8gjrxMOwhCPwyMWKstrQdDjVtka/0zBrkU6pdNT1w6uN+FHSlFAIDqeTXTVck
         hngTBovhuZIVDPbTZZg49eoBWhjtcouEZ4/cMAJM0RxN7vdHHxtypdeoJuS1Wwn2lbnW
         M3nnq3ZCAHv0V4fWGzZKn58p7QZWmhx2bkNzBErZxTDI5rfFdk37x4DdpNE1cR+RIY1o
         s1pseNXCkyuWRfDUnyVvSGLZvzM2KJCV2UmMZo/cXm/z930u5tpUvGjO3XkK3lIl1R3S
         fEoTRBZWGTZlG7XvDShNhzk3WGy413amkddOZLE6Y2lFImJlF73l6EzmG3SRCqBD+qBj
         E9AQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Etw4bV8NUC423y+sFXa8GclCqAYyNgAD/PKEE6D4hupBN/43EazA0iwoW7tklPWn+MrUIhDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybaC7hX1jzsJ0aP94XTfUscIIs7MGtpbn7kcx0lj/8SvtpWsHk
	zxejtdKMrTGkZMgR6G4/AsvC235ja3CogOYjIGZEP9z9asowHzELBV4Iz2OnLrQIZEw1jmTQHzy
	QCefQxwJ5kh7iqG/QeesPkelnXBC47D4uBnzbfZHy
X-Gm-Gg: Acq92OEEd7nJQxlBDtI/czaHpzZCe2JrPFCO/Kc0raQQcXaaAUWlXkOrP7cLebs/oM4
	z3F6UPxFp8vBq/JoHRw6WFdkC1ALxC/PZA0KJtXpIW+I2d7Asd/ZL7v373NucjWei+jgNr3GrwC
	CVGNhGo5clkozNU57H8wI+m/vyqRVnlJVmdoaTov3ulTdbRk0CzJnfOEjQYclrz8JIwlHDpfIB4
	RdmQU7+hu3SL8grsIgoF7wuM8M5G2xv9+4dqjJf4GbhOIcrrYccJmsFrbwmcO7ETc4XEZxb8DFj
	aGTVRT7TC6sETSfzPAQEK+JFdh/lywDVQrC3510HZQf5bC73S1+EL3mHFIlLrXZSWro3jRztGQs
	cKljoYYezEuVdde/4l83pbCb463kM
X-Received: by 2002:a05:622a:114f:b0:517:8792:12ba with SMTP id
 d75a77b69052e-517a12dd569mr222424741cf.22.1780967050409; Mon, 08 Jun 2026
 18:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609005403.1241111.e9391ba4793d.htb-active-prio-change-stale-row@trailofbits.com>
In-Reply-To: <20260609005403.1241111.e9391ba4793d.htb-active-prio-change-stale-row@trailofbits.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jun 2026 18:03:58 -0700
X-Gm-Features: AVVi8Ccmr9GxkcdJTJNRph58uDc-w-eOMaGXkEzf9kKMjj7plnJRRtIrRbb-X0A
Message-ID: <CANn89iKUYdYA7k4YZo806cb-Oz7qL8uJ-REc7prp1=hLO9YeTg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: htb: move active classes after priority changes
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:TC subsystem" <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 5:54=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> HTB lets userspace change the priority of an active class, but the class
> can remain linked on the scheduler row for its old priority. Dequeue can
> then treat it as if the old priority were still configured.
>
> The scheduler data structures must reflect the new priority immediately.
>
> Relink active classes onto the correct row when their priority changes.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview

Please stop your bot immediately. We do not want to process hundreds
of AI patches per day.

Please only send patches that address critical issues.
