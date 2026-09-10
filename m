Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206BD38F651
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 03:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010493; cv=pass; b=tRavU5ftVGI/5yt2ZOUXiMY6Ryrvm0RZJ2dsKzRmbQBDRf5S7ipEMC91U/69WfiTyIxCZO3NndDNefUBkyO3G9gvh63U7iJndgmDonFDED8cl1eL3b4j2hM1T9LjYfu8Ofs1f2/6t+oF8YfS6l0vLHvtycDYWbME6tNeY6O+c+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010493; c=relaxed/simple;
	bh=d9sO9YfjOMtfhkKI218+Hml8pdw2xki6+3ssCBL+UVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+67bBndrpOg9CYlN7HoQxyI6OzqtnJgKPlmNhcgDswSNuPKt0wEQRzGICF9FQgPMtb6ec8tVAmbVXk1HTUBT4KRZE1XSUH1WfdZdD8/sNo7AfljnLC8e9t4vWyNuHQPuA5qxy8zEX13zD0H6UPcj61tve9VrXXFiRO+0+3j8lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWQ7MXUq; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWQ7MXUq"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b76515c0d7so408860e87.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 20:21:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789010489; cv=none;
        d=google.com; s=arc-20260327;
        b=UkdkUFOtBdwgDCDmhN3a33WLv2y45mN9F1eA+5K3nkx+t/Pp8lc+OXt+o5SFLlnEzn
         Fi5gZA8Hv0EeqoNMYgWeX/9MQRbjakcBiFmm5JgN7ANATRMbU8rokgEMuMa9gozm52gP
         iY+YLwuT4pUUXegzW0pu0AK9y8MusUYc28K2nJHJRgF7UFAxf+g4ZlCCPoJ2m5KBvebl
         xBNmVoJDXGgjNRLRp+xd1D1YWVi7cu/LjLK4Cjg9UD02rhjb8T1/1tiDi0TBCiBCVT9g
         +85WT4r9kQjPRdRpz+dK/D3hiEK1pkxf1HYJ2viVL6SJe91DrhTwL6mFQDd7SSp/PSHo
         kNMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=d9sO9YfjOMtfhkKI218+Hml8pdw2xki6+3ssCBL+UVU=;
        fh=db461V+dTbZeBFHIQcBJTIaEKPrbz2yp0OglxG+2XLE=;
        b=JLpvg854FE2DW99M1PdM0Y/qmBGcWw65f1CrliI4ndsuixI1GEmPtYxrCRbaskwH0J
         dkIljE4PKH7NuEuPDGIGlSXTovk0CgX+lZRlw4DSF7iEBiOJ05tXtOn35obdMXOU26jP
         1T4nD3KAtNcmqcwBmn10SbDuTfdcxITEyg9C+azHWDKnTRe2T73lBPZzzxB+v6R29bCl
         XhIcpPVqWvthhzcAOvuSn3mudwTWcn0MliCqaYdWDO54vGlWv8oqsVwDmhHCQ17fSh8G
         aA3PZ3Ww6yRBZguGSWzjc+t2ArXwn5sQ1Msp1TVgXwlZNp+IUkgmupbqjG3OXFGxowwC
         CJsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789010489; x=1789615289; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d9sO9YfjOMtfhkKI218+Hml8pdw2xki6+3ssCBL+UVU=;
        b=SWQ7MXUq8hWauQt3woccc8fdoH1ixQ2nrXNn/BjQWP80zEtOoB9H2o/2oAUCncxq6z
         +LYl5JKPujjfKOuRZ76JqFLukjKgbmksJ4vp5iXC2OUDcfmVXMl34PjJjnRXYewANJ1y
         PI5zLMp7k/PYQQMUluPqoy0KRqVRVxysSr5PUDc67xGZ9FPPAn3hU1B4KXC2G2rP+DVe
         jyzdov7KQg7afQKPXinC06msaYTylYaeiTuKa0i19qf0lKpD/sctOmNCz2brzq+u9bLy
         kFhBAROKwzpc3v5aogPct0eS8UDOyWnomU4AhnHctSIwZq7y6+0THzTK15vwZzN1lisP
         UnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789010489; x=1789615289;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d9sO9YfjOMtfhkKI218+Hml8pdw2xki6+3ssCBL+UVU=;
        b=MH8gmz5Yvbkc4KcWsAR8mF337ACBrOvUWjRlSb8St3EVMi7/9AOly5E8VUxVEBKVzV
         xqGp562HwpFk8MNvx5xIUfu23vL8n0Gzk3NoxpB/chUG8SYG6C9RnBrq/jzVKzDREIIy
         49RRvqb1q77fNl1IizuPWdX+ZldlkdezQ7rNd4pr73HCcJOq7qCvS8QbnczpJ1vbmGtv
         w9Z2x5z4aDSFPmQgH6z+IrHwDE6QTKh7M12yIc1lHfzZqiohsqRnaWPM03SgUwG8UkyD
         521EapA9QUJJ8uzaj0ANWUEvC+cB0WGpsYTKSN2DWb+jWtuld1EGX7KT4lyP0vaZ7xSO
         Syzw==
X-Forwarded-Encrypted: i=1; AKwUvBwrP3L9lRIrf/kw7PuPlcz2M+ab9ZwDYByFxwt00aWka4/pdBxYHzukKEpzx8Ov/dEuABFiM+c=@vger.kernel.org
X-Gm-Message-State: AFuF++kNKG42iQWUP8gyJh+nH3J09cT+OpfCKTSuQXyDfwc41aj7gnbX
	UE+Sg/PM5QrZiuncyEyfARprp060VHJO1aNsy41QSMM98H1kBU4/HFBcsfzikkFkr/FwlflB3O1
	EQl1X8wHnJG8uw/3XbMQuAQtP93QnDO0=
X-Gm-Gg: AYBFou2WqDpJIqP2R2b1roJdxtH6UtwuMfw30ttCggm8qhFQwGWBfgcHpbXKQSmVet5
	8xp0iqrHEpyoisF+OTKHjAf10tw33bAqvfPdJwFDFn+u3ZzNDnRVCS+j+g1uWlQ79Kop8U2KGlk
	JP6cmC1BZfuN8cJhNwKEa/HWmuFrOrIRqSqnCndLErtN/VhrBCi9BTxqG+ERttd8Pf4RLnTMofw
	X140cZPLNL199Tv60l81HrpItQzmDCNqTjjWTUPUuzCi9UN84nXRGuikjdWjKW+5nNGAWGmcLPo
	Axo9M7SX/+lq+7WfhP2ZlyxIYH2+8k60AYmDUUsusr/1usSOv8wpnqI8+zYF2yRPeypzun6SUz/
	mlODUsrKmpW/JMc7F5LmAwV1Zvn1TTOxOPUF9bRbPwQ==
X-Received: by 2002:a05:6512:1307:b0:5b5:e3b0:231 with SMTP id
 2adb3069b0e04-5b89a2fad8dmr399549e87.13.1789010488773; Wed, 09 Sep 2026
 20:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909013401.14408-2-sigefriedhyy@gmail.com> <178900489222.219967.5701707176821161509@kernel.org>
In-Reply-To: <178900489222.219967.5701707176821161509@kernel.org>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Thu, 10 Sep 2026 12:21:16 +0900
X-Gm-Features: AcwNN1V7GyyXN-MLzIxbdYaXEdpcN2buyxt9nexIpKd7w-_caM0SlF_aUp8xaeU
Message-ID: <CA+7S2v+kkzOxwp_o7eJ6e8gCGhqvN7ua52jsBNsCM1hMW79VNA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/3] rtnetlink: add AF_PACKET multicast dumps
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, donald.hunter@gmail.com, 
	edumazet@google.com, idosch@nvidia.com, kuba@kernel.org, kuniyu@google.com, 
	nicolas.dichtel@6wind.com, nickgarlis@gmail.com, pabeni@redhat.com, 
	sd@queasysnail.net, shuah@kernel.org, horms@kernel.org, sdf.kernel@gmail.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Could the changelog drop or reword that claim?

Okay, I'll drop the claim in v4.

> This isn't a bug introduced by this patch, but can this copy expose
uninitialized bytes from ha->addr?

Not related to this patch, will send a follow up.

> Can this positional resume cursor silently skip dev->mc entries?

In theory yes, but this follows the existing dumps: there is no
generation counter for dev->mc, and in_dev_dump_ifmcaddr() has the
same window. I'd rather keep it consistent than add a counter just
for this one. If the issue is really worth fixing, I will send a
follow up to fix both places.
