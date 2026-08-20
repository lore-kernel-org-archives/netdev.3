Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9D135836E
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217603; cv=pass; b=KleIUJ111A+FTK3NuxqQZThc/JkUbWTB25lshQDoVrnBzuPbWHrjRbddLcXvAzb2IGCSzO5aSGN4Nja5ksNduU9pNOVBtWcwi/hFseMr46MPVneaOKOlfkXY8fWv09Mwi5QvA2KTUiQk/TcYdqiOmLNdf61ic8Q8TCoO5XM/Fcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217603; c=relaxed/simple;
	bh=PfGX1/wpefIpzWNzuSRhv7ZZZrMl46KjkAc42CrnpUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PzIPK9gHTp1g2gPlOP6LqDPfdogGmlyVZWrLqKFODd+EuRmDlPs99/JkTNgZEGeub0pl9AG5MCn03kyKakvcwyg1kxRlpmtPBIIPMs8+K3iYYI4aHe1ZzkaNxap1ZNPuojiCBsVvdtjcZJxs6OBEhUqiv0oF0IypG/BcnJ0Aiak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fw/QVnlv; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fw/QVnlv"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e50a650a0so113382885a.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787217599; cv=none;
        d=google.com; s=arc-20260327;
        b=jcLBSd6yYRjVkt5o97IlkSpR4JcVg766VMcO0+5gD8ue4KzPxIabWIKkmchYrZ7r/+
         nRRGvPcsEOjpjuBVpmow738LIE886WWpfI+GbimhtDJ71bAdzY6yiE/pbgJAcvmXGKC7
         dCJDM6ZcA39lF9ytv5UsAaz1YFWihBydLS0oQQCopRlI+Tw7Fuf9eKEX+csKvmjFKNL3
         /at/ZVBh4S5Dz+VZuDHwUMtGydGyc7PnRQjhtG+/fy3ffCXTTZzt5+tYwQWrgQMHmpJ4
         WE6LZSfaNLYAXO1g9SaXr9RjLMEmK4r3bNrveDo80pDD1P90pLAIo2fIdngtQt+gEeSq
         PR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aJfvNW4O1AiSSOmbGxVJcg0QkmSuk+rovKT2HmcAFeA=;
        fh=/bMG/RkjfICgR43axEVrBCe0WLnEFICbffgBReS/zKQ=;
        b=DyNkOqTqIW236Z4A3K2drAQ+mTIC9T0DfP32Si+6Dmdn4RNoPQ15mQZs94s0JxcmWn
         dH9CgH5TYBzZxmWb2P7ysbodQ14grBUw1u+/irXbw53hoCTDd+XryOyRNmgZhS5J4P1K
         cGlcLUvEBFtdygVV2JFjBx5wCRWtEpwH9DKdg+hXDCTLC2ulifoOAfANsBIE8h1VwcO2
         6iSTbRXqG6+bOl3FWLw6qbHFUwWk8d34yHiaZ/ERnOqFqlc6TEtCY/cx0ga3DBnUyeFN
         dXFMab9wCUvjGkqN3NMjHbiq6R1eSyZj6Lx9+ZR2oXhHvOkh0rKSqss23aEEGppAKHGc
         cSPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787217599; x=1787822399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aJfvNW4O1AiSSOmbGxVJcg0QkmSuk+rovKT2HmcAFeA=;
        b=fw/QVnlvG+W8IppGSXTGFTT4p3/vPmcL0XY36F0n2rHJuiV9FntWuMT7UPqqQQ7JvN
         F/FndSmZMG30ULIGRA5+azM+n9KBb0UmmILAeECz+CmWUbQM/A0qX8OJRiNwBlOtsxt6
         zTBWbV214thf0OGPYus7NT1VEoAkCpKZhADdk3yBnmtO8WEZPP4AYzCbmAy/IhmkvK2P
         68SXGygTvuSkKySLl+CYpkCKGrwdOXufDT4eTuPZPTWPR1dAFL16AdsqfdQRwoIt2ga5
         G7pK0jzuMclKQi62axy97g50qSupb6yh7acwH1Mz5BNP4xkRuvvmtEupv5L8Vetu1pgV
         kQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787217599; x=1787822399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aJfvNW4O1AiSSOmbGxVJcg0QkmSuk+rovKT2HmcAFeA=;
        b=WN5fqVpgv02oyKE9IVrGrEl9VX2hbvhwpvDmGb+svidh8/v3yo+dxNPxQpEIllS7NB
         BbNHb3a5Sns+iDdLl0n4MSw9/rWANC47cM74S0UBtG//ZIrDEYgHcze36hoICQZjrCGh
         uxV/TdDZLtdOjN9FNcihwmom+BneXFJV+HeGfKkv837gIopGKEs4LZsqwOlhLu9ugI32
         HrvwKGHqCSM09Ieq1qc3Rvq8JMn65SnwqFFkYHq3HbOwa8bV9teOntr5OFBZFROLmS1N
         biXi5NEue+ioPhZtovCkHiuAE599J5N5wJloMegRE5RJLixWa23WNdH/mT+s6HVAUIIe
         6mCw==
X-Forwarded-Encrypted: i=1; AHgh+Roa02asEgwrTbC7bcJFYhX4aEzUqHQucs4lEFb/tshOnVAbUow7jxkR4oiRkjYNlcRIdCVKxK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTlxkE6d+Uq28VSXy86BVv+YAT6Zsu7yNQhO2iG0Y8PvYTEDwg
	0hIJjEZLr/tGToYkUUv+EMdDSiaX6HD4pd07IlSK4S43co3DEVtRiOA/d3NoLBQx1LwS6F+ayY+
	BFYEb0Q0fAaIiNh5yFFEUj6Lgs+a5YopVuRLFkTkz
X-Gm-Gg: AR+sD106Syc2SOVhRiZY8R2pLA29as8QxYTcwB1GNSAGw3cwSd7O1QVeCqLN0nIXkxU
	LMu7n43G+SCy47s9HL586cDIpNhITbTdoP091apDMU4ROh8DGyR1gheTFcN6/Jbf5d+MXoCyP/g
	yQ4qIovwldlRyY8sDOlBvBe2Sa3MtOw+wXWMiJvYttKpkA3AgKsMf3pP9olvTRTd8vHslmwuqOU
	Hf7H4sk0lLcjVLsWa2sKqIrNfNQepyNmlPICRRBccoYRv/yr9SmapycU9MVsTq8qmROcsjlLPKG
	iPQDxty9Vgdb7hBKFXZB0o27eIPKur9A14iwhteEDIF1oe3quKKq/62+uBlFcQrnfvlYWXiOhFj
	5bMw52SI/wPy+0fjWByMUq8ffjwXyQBzku1JBwoa3POS4RJxpA5bbTGnebw==
X-Received: by 2002:a05:620a:46a7:b0:915:e670:4021 with SMTP id
 af79cd13be357-9371e67b222mr866252585a.45.1787217598107; Thu, 20 Aug 2026
 02:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810141125.1176545-1-edumazet@google.com> <202608201604.4Zj72hcA-lkp@intel.com>
In-Reply-To: <202608201604.4Zj72hcA-lkp@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Aug 2026 11:19:46 +0200
X-Gm-Features: AcwNN1UNhmPI6Cu9T5MRbf4miQkt8_m-Qm1afUz4ESsXXfusjBk37G412Rz7Jzs
Message-ID: <CANn89i+BZ8HgXw5KYGxMRAoFMsfvk1GF289E73=PCN+x5n15dQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] l2tp: fix tunnel and session refcount leak on
 seq_file release
To: kernel test robot <lkp@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, oe-kbuild-all@lists.linux.dev, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+d6fa74e3f19d6ee01e3a@syzkaller.appspotmail.com, 
	James Chapman <jchapman@katalix.com>, Guillaume Nault <gnault@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 10:13=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Eric,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on horms-ipvs/master]
> [cannot apply to net/main net-next/main linus/master v7.2 next-20260819]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/l2tp-=
fix-tunnel-and-session-refcount-leak-on-seq_file-release/20260810-141125
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git ma=
ster
> patch link:    https://lore.kernel.org/r/20260810141125.1176545-1-edumaze=
t%40google.com
> patch subject: [PATCH v2 net] l2tp: fix tunnel and session refcount leak =
on seq_file release
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/202=
60820/202608201604.4Zj72hcA-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 16.1.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260820/202608201604.4Zj72hcA-lkp@intel.com/reproduce)

10 days to test a patch is unacceptable.

Please ensure reports are not sent 10 days late to avoid spamming litsts?

Thank you.
