Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2194A482A
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301849; cv=pass; b=pOZwK8xKgZCF95kuZmK6Ih4OespyYZkBnr2MNIg/DOSe9c36uJ/POpEB0KkeAx9n1UkM1UY1DBTNmm3bu9gBCnEFzy9tuNrGcvCUMEMWROIcvfgyIF1yTH6ZwfNCPNfS0177BRAJ/5PnZlxcKGU5rMkQiPPDD+ES0vGl4W6AEk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301849; c=relaxed/simple;
	bh=gVTf+5nPszzSOjjP6JGia1N3BVw0TCy5I1d9nkz0VXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4xJmUAI77J/Sfewlg1Klr+2t0pYYl/nqKg/ClqY57/R6dO1K6I4TVh8uEBNe0FU+a1Mxt8SZZeza6BaRz3dROTUxm5dVwGNmTmvDgcUGXUBwLCOrjkjiNcsKy7JJrBnlbmD+hK1/hs2EarcXJ5UtyP+g+Y5npzMLxDhZqlNBik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=gki6Svi2; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="gki6Svi2"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8ac525c1f05so29401867b3.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 08:50:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791301836; cv=none;
        d=google.com; s=arc-20260327;
        b=HrNizZw0ZV3OT+k6c3aLMg247s1vwNLezL433amBDW7mc7Uy2ziwCsa+KInCR6uVGE
         ra1WLWuwDYE54buMuD3XLnYFtAcmKvrzORcsNVoFQchhAmugx0HqeUP4o+No4HFQKDXX
         NRoF5RWXBsui7hpuNsFpV2d7EZWLXByPZunCwMVWh1t3NisbE0ZPhA7DvO3ncFkNCdok
         jPQ2bE8BPkiib2anDUV3Uj7T9tUjdxZhYnOKqy9k3j/hzKEvr4shL/BnT/FRTpCWaNQt
         vqJfM2eRW43FIUc4lpQ3zvDO+GBv+1fUUdBY5Q6g+g8dXiuIbFwUmJtJhNLsXV5RuVfx
         0t8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gVTf+5nPszzSOjjP6JGia1N3BVw0TCy5I1d9nkz0VXs=;
        fh=9ZfcehHcaFez73PgZE9/V+V4q9mkflZKmiF/vLuHkxw=;
        b=j8IbhM62BQ1HQeH7FLLBxGizAbH37JlTJtD4rew8yEwXRLVwCzY8a3s3870VMq1WlX
         xY+DfmXbI0H9vL8gbBSB4RpWJTAjboOrqFlL777ZM/N4rwlIxRk9uyrVKu5Za0bI1VeK
         s+az+IgOlul79Ffqpy9LJ8Ou/+p1ke8rjPLxwo67FvuT+dUtrC1mGTXUdvZRUZY5spxr
         llKErQxoCQpdB7f6sx6iuKbGSXdPp3H/fcoOdF3iATNSXVww63kKC3SANUth+6v/fzV9
         MRiKD5x8VQF+f6MoDMkKiwmlP5CNgvhybkEfgvAeW8ZV/qQ0UJ+KyRg5KU/UgbvQtnvf
         RXQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1791301836; x=1791906636; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gVTf+5nPszzSOjjP6JGia1N3BVw0TCy5I1d9nkz0VXs=;
        b=gki6Svi2szPl4fPOLey5yofaTe9T1X1uk7qJIIgc/HL6qGAd3L0PblPbRnYYDkO5lg
         PTML60AJr66UtvL+6+zKZFWpgK1U6RkUNzk92+CeDirgjKTLAq3zBoUZy+iW1nWZfsPN
         wTxL3SLYyhkbyxvXHMqk//CqGs//+7lpKc+uZET3BH7ejRQSrCjVSDuqNZIZbuvUcLcW
         0N5Cogbw6c7NU9jTz4PQh7Cm/Y1/bcQUGk+RrIBFHzEmdEOugc07gqJ1/vfuVICj0mW+
         wvIFGjkaP08LtOLwMNPdQ2cGn6pUCEI7oW8E18YtZp/AnPTEaSLdKRT7SGre72+YDDZP
         pPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791301836; x=1791906636;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gVTf+5nPszzSOjjP6JGia1N3BVw0TCy5I1d9nkz0VXs=;
        b=XU4xHwqb0Bv83mh+pFQMLwWKNgD6DoKLGrGAuw7XZHpQBi8AxdKEqeUovWccP5Yx06
         Afrj6yiFwdraEVla/n9zIa1R4HrQYshhJMvLGeeSVPSGBXPCF56VKJlZ1RyCpewMf1Ui
         mpn+sZ3WBHJOU2Ody6osBg82AM/O4ODM4Cw6YuzyMDb+g1cUcHQ1SdYSWMXhcSdj+mfD
         TGXmspeFsJ0PyrBHsKfwpbGkRuTJk732wTY0LtKT1sct0IM2AafrRKpLoqbwIobykh7i
         Qvd3h0YAbvBvGIyAcaDv3UoKhovSgPT5kHOvoVAOkBE7IDhyRcjKFacl4SjW4Hhh4v/J
         BqQA==
X-Forwarded-Encrypted: i=1; AKwUvBwsfigQwLguQBn58ZU3Id7CzAnMop156O72l/XNwMOX2tzbkogt6fMrflsE8ilweXdgOVULoAA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL9TQdZSvJQaRtoTRzsYMlvjGnZK/qx7jgWlryi0WDpgZch0a+o
	gK6CMir1lioIMpqqARzv0kqr2ll/1DCDTGF4o9duGgu8YbKFtq1ocp/Euzed7sDy37E+9h+OTFq
	zlQaahp3Y/j7gqOGBRtSwnXrK5Zu+pPAMG7vPobeWJw==
X-Gm-Gg: AYBFou2RajbDrRGGa4aMr5NTxPLx2OYeO0kK4g/MT7PmgEazZoIspOaSZa5ry2+DaIt
	DqyxXEn/e9ek+uX6jEXmWqxaZceBwu5njWRZlntSfqslNCSqZOPF+h/QpjmJxIwZKhYjXp9P5Tg
	a9zO6A8gAoLElfJkp8v9sKj/iLCJd7h+QjbSKYZ4p3wey5MGqFrTE00NorP60iDmexHKogLDK2J
	pQU9OOV01HroZxYp4HCnQ9cPl32XQp9T76wbHL4VtK4WzVi/ZYzGRoH95+CpGz0iF9Lum5XORpK
	afzsjtidWnDFUBLWM5V9mq1+8kDViM3HemTq/FtrEY5mB67GIILrNkphChVvkMEM+IQbTDQaIGo
	rsQYWYkRePA==
X-Received: by 2002:a05:690c:d8b:b0:870:107b:6359 with SMTP id
 00721157ae682-8ae94cb498cmr52594837b3.15.1791301835837; Tue, 06 Oct 2026
 08:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
 <dy5xfj3754wnp3gh2kpoyf3vpx3vfsfhblgbwbwsgts27xqxga@dzb33gt3zgca>
 <asQcQIh56MV1OJur@lore-desk> <CAEev2e8+fr1tJnSErD+2TtLDw5fGJbQOMcM5eefMnLyFUR+m7w@mail.gmail.com>
 <asSb3RNcityVg6ia@lore-desk> <CAEev2e8c6hZQQom6NV-URgdSoWiafCcRR3BtA6yxxqy7T-me8g@mail.gmail.com>
 <asUGoxyJWVcsYBWG@lore-desk> <CAEev2e_+Dcj60Rj2+_UD=3_kNQxLK4rmWTGK-dr-Ve9mGJBARg@mail.gmail.com>
 <72e19e46-3a14-4a07-9b50-01e5480bf1a3@bootlin.com>
In-Reply-To: <72e19e46-3a14-4a07-9b50-01e5480bf1a3@bootlin.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 6 Oct 2026 10:50:25 -0500
X-Gm-Features: AclHuK8RliQGPhyySeVwku8FmQeRKVliSgaQe4flxxpUxxtotWhsC2bRW968fZU
Message-ID: <CAEev2e8JDjU6PdV+5PjA90YqiMs2bskLhNgs_gAp2AAY1quMWQ@mail.gmail.com>
Subject: Re: [PATCH net v3] net: stmmac: propagate PTP addend and system time
 programming errors
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Richard Cochran <richardcochran@gmail.com>, Jose Abreu <Jose.Abreu@synopsys.com>, 
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, Drew Fustini <fustini@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 6, 2026 at 10:28=E2=80=AFAM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi,
>
> On 10/6/26 17:12, Anirudh Srinivasan wrote:
>
> > Maybe someone more familiar with this board/has used PTP on it before
> > can help out understanding why this is happening. Maybe this is some
> > issue to do with clocks.
>
> Good point, can you give us the full dmesg log of the board booting ?

https://gist.github.com/asrinivasanTT/d1b7957cb6ec7bdfed66af5ea3a84631

Regards
Anirudh
