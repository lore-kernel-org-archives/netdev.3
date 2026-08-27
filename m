Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91473CEB83
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 23:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787872371; cv=none; b=kJukjxlaZubwW7QZ8RomjspZfZH5ENtYFwnioAbBlBX9NglgeSwsGdYLEwzQxaeoNlCtk0kLLi8QqS6qzH8s6ekNiYLOYKJcnaeoDyCw6JR1YEoS3hVcMPe/Wzbfa+8ymdg6S0YKJnIoBk4Zwlkw9jzj57IRXMlRq209yqNlt2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787872371; c=relaxed/simple;
	bh=W/VboFtsniwlT13CzTXqyyKAo6bLiMCk0pQp6dNAoJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAVjEUGaGTr/vt0GN2IZut/sz+uuiSm5ScaouOwgeaBLHT0g4GjhDarvan1+1UNg2awoGErBL4PAQqSLpNB6PcV3fuw7uiiGjPMb/hvkDaHccPkMsmjbTwpAbnFKfwX5ogQcIKKEOwwlS35TUK7UG05n7pSOsEeFSMUz7TQ4cEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=buVTuGqq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="buVTuGqq"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-39682983a0fso329699a91.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 16:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1787872369; x=1788477169; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owiJggVEjqcjWE0DQ/s7zqsjd4JZVI2c130pUmNZmGw=;
        b=buVTuGqqD47M3f4PAj6OgpHPxdbihT5s/5hK1VWsyxLTmynWwOzbsNBTFhFF/2qytx
         +e1pZxOkuKAPI32nBX5rlyFQf1jRTdQ1LWz1tWJMNC9bVML4yg4a7HdndvDimhmhgAN7
         aASBsn69NJiuJu87GwKQpc1PR1TE/LH9DtvePRC3Wpz7rPB85HCQpAb3gzMAwvtoqlwb
         2g6QrdCmkv7F0DUWwFR6C4hiGRTYFeeNKPJtbz39jwKtno5Pd3207JdvRmtP0jxYVjoL
         BeOKNjOOsFzmOe2zicucdxR5wphaV/hzb2wNoVJZRsOQxxfBMM5c4Is6hPrPXh2ajMWd
         FCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787872369; x=1788477169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=owiJggVEjqcjWE0DQ/s7zqsjd4JZVI2c130pUmNZmGw=;
        b=YK8S4xSQ0HsfsT6UTUGTxSizWiZ/4yV73EVEBPewHnGzzx0M/sLmEGaOJmNKvBS/qp
         Hgl5r12cL33Zm9TDrIP/8/Wf/srWCUktwKIekcd+UwDrdHyCWQOk1C/LDcDth//nJoIq
         0sQfDmC5f7oh6LutrHJc5PpcAiEH28Xz0TgMp7nL2RkI3XXmPmP+xQmuKjILecxaoaPE
         U/oI+fbV1R8Kxe3Kkx8Q3n/SMhbCaMG9otrI4nX75tVPHgajCj7pEGZbtdW3L3OxHlms
         MdiancA1DCU5oj+XIzSUJdVton2CS3rro9Uvyw0FdEkUWrmr5ZKZ4Apa4dwwNsc9X05c
         ijqw==
X-Gm-Message-State: AFuF++nzO1odUUgLgiw4M0q4Wqd+q4dF9IppNv90mu358IKigA2SjV4q
	S+0imq73zNC4JOYiSBP2dzBkx1RUEdPo/OrpV1xDJyBHBZcqGJFaXhV4jTzahllv/Cg=
X-Gm-Gg: AR+sD119HGxb98KClbr0ArAYgMEqJBGV6JIle5qUL8uM3Y089KM4M/Ceml0a640WcGR
	zKCKfN7nYRZDElqt86DwV+x8sNMhljAjqUgVapSKKgvhLQbkEcOYi2u2DmDxtcwXMp7Jgq5SxIF
	C8j9onBJNVRaF9y5UOObEv66JMpr7OpYrxzGMg/aznUC8RDvhEqwMT9BnXUToXrQ5VG33KirMbQ
	jQU4HrlkP/dK0CevUa9wuXcDYzM7vYdmpkPLGEhHvRdDbC/xlqkAnMnFpCtllNVlsP2YZOIFXO9
	RhnDY1L/0IOiAF3j81QuN21x+m+aRzP5fa4kK6nH2RfKvrYSdFvmFQAmJiLUO/5H4qbySLIThaf
	+ZiRgASLo0S2gPee1IERyKYTaM44Tyj5WC6x3fGhorTEttaKn74G58qIcHRaUl+nvV2mas6Z4RX
	JagIfzwtWvqsRQN8eA9QdHEHs4EyG/QLvFuXFSvy5n4LU=
X-Received: by 2002:a17:90b:380a:b0:38f:de97:b06 with SMTP id 98e67ed59e1d1-396d0daf810mr4835678a91.5.1787872368810;
        Thu, 27 Aug 2026 16:12:48 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0d3c9e4sm4598254a91.2.2026.08.27.16.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 16:12:48 -0700 (PDT)
Date: Thu, 27 Aug 2026 16:12:47 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Colin Winegarden <colin.winegarden@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org, raphaelcf@meta.com,
	stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH net v3] bnxt_en: Bound SW TPA IDs to prevent crashes
Message-ID: <apDEb/LIqcrI9LoV@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Colin Winegarden <colin.winegarden@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org, raphaelcf@meta.com,
	stable@vger.kernel.org, llvm@lists.linux.dev
References: <20260827185700.2157164-1-joe@dama.to>
 <CACKFLikJiCdjej4ezF=U16Leef3oAjSZGQAyetRnF=nLRvUfZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLikJiCdjej4ezF=U16Leef3oAjSZGQAyetRnF=nLRvUfZA@mail.gmail.com>

On Thu, Aug 27, 2026 at 04:07:16PM -0700, Michael Chan wrote:
> On Thu, Aug 27, 2026 at 11:57 AM Joe Damato <joe@dama.to> wrote:
> 
> > @@ -3831,6 +3834,7 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
> >         int i, rc;
> >
> >         bp->max_tpa = MAX_TPA;
> > +       bp->max_tpa_roundup_size = MAX_TPA;
> 
> This is strictly not needed.  If we return early below, it means the
> chip does not support TPA at all.  We skip allocating the TPA array
> for every ring, so it really makes no difference.
> 
> BNXT_SUPPORTS_TPA() will be false if we return early.  LRO and HW_GRO
> will not be supported.  So I would say it's a false positive from
> Sashiko.  Thanks.

I see, OK.

I suppose that means I'll have to resubmit the v2 over again in 24hr?
