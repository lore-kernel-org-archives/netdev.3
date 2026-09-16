Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623513BB114
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573431; cv=none; b=RmDC6g2/yq9UDA+6OrJ8lGTyy91Qk2Ooh85/2mp9Sr40SGDYokw0BuLiihSxQ+S2ekJua9h8TcdO6K/z9DiMIJtY0Y611+VbHich7yLJ35m2q3KDjWkApztEy6L1TochryWHzwmCTj0AhpaqlLhwUHI80bx8k4W55/J5ik6YVfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573431; c=relaxed/simple;
	bh=7b4U/fGsD03FJ+1cJzVAcm13q/obiwTa+uRArLXatSE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lBg7zPCYF9/0Iix2Mb2XY0TiOUH/p0ieIdf97oDh4XIHm/LL/bExSWcqyyj8nxfRf+iVQhDIwEOVUXqeKjWw5L/c+BnbNcVWWzMhLLysDPwC8BKuJAQp4NTr2IHJtmJdVpEGToArwGMfVmh+Rpu0y+GsRL+tDRt+I3hWsiAceIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=lFVd52FN; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="lFVd52FN"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e25400so920104b3a.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 08:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789573428; x=1790178228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RlWgaGvVMTWAPCdLWRbEgBBy7dvyRbhMjOoo/JDKg2E=;
        b=lFVd52FN/0gYXrwkooPXYCOOdaqOIUEtdJN0DFDTdGBcOAY8rWUglfYQSHXWi3Kp8L
         rImaN/b1Y9tDFNMnEJJwsaknDx5R0yK+7WqPRC1J2RswW6/Q6QbPh5J1uYs7WXxurxVS
         WeG6kMvYVdjlqIOEilQ4NsjjelLU1aOz0J12jWzE3F68gPpth95BO9K7E/1mzVH2zkT4
         RE6HM7mwSsUUf4Ei46FGAf5WAEJ6w6dMafS7+QCT7sv8ebEihezJ9T5qioWk5LAgOgKL
         6LUc0yTZDBDyQ9iY1WvHUmyNhQn+j6YH4BwnWh3IPcF7sgZKEBP+J/r5MT5TnHUDiXc8
         R3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573428; x=1790178228;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RlWgaGvVMTWAPCdLWRbEgBBy7dvyRbhMjOoo/JDKg2E=;
        b=h7vh8OqF0F3cV4Vc5krHftwnsmzISWbmi90aaLFDf7vRvu+12BBVgmowXMP96w4eMr
         FhFbnBwchTD6+CXScw6f29NRvxbOA29R9xAWzMWfv9JOpXYOqjphR5TEXmKVIpJuQjdX
         Qb3I3zDBgHxtBawNgnYi8ZJVunniX5ltl9h/tUw91sMDu3Wbv5tYIrTao4LmB2nEuTz5
         G6j0Lidz/VKweo+ge7CRJPbfrMCYThTWoBTbVFM9fUYAZRtd3ZLiq0xfEDlj53k6uMAe
         17a7v3kjHpVd6Sk4PdJwXVTLW/gUI5outHkvkFDY79Gx21uc1XHZObO2qz+/9/UqxJOB
         Fi1Q==
X-Gm-Message-State: AFuF++llAAmgAdFCL7SLF9td/rKxr/3ihnuAjZaufw16MB4MMEuL8VhK
	locY2dHotediICe1jFKz+C01Ytzx4KGOgV6abjDVUUqbplS6K0xA6ca2+e7do0fejKw=
X-Gm-Gg: AYBFou0+YefzqyQXjJvgB6FLYkiSSq7k5lba/DxW742qqNL+s7G+qOgUbYgIzOFFY3k
	s9zwDMBq0pKMkZu732ROkaEEbmehqUF/LtUnfTp6dcwyNLeobdX0Oi/oxDwqMNYY0hGT2eFnGif
	yEZ4sIMTczmyw7wp+iEIx78yroRZKAsryy6yePMeBbOkSam+jvDDd/itnNLGjm8NWF+YRH9iM2k
	kXSCCk31gaDqXTm9Vdr1gUuORpRbEHruiuNajhuLj9CkrjPDdkwTxvfGelDOmY5nay8fgb94R4+
	VHqguwC79zh5zs2veMNDsnAm+4ZWSKDailOkf+tYMOuZau1dNHpMS/IJzwJOQCrPjUPoj/XrMUW
	Pb2ctXQZKCa//JHHAVVHTyeVFOU/fAdJ/iQLUPfzAYZy4C3+r6A43VcCXUsDu735xgn9Ua8FHnA
	jEviHdXMVRmCt2FzPNtfPMeFkCPov5F2Zqezz6EHskX7MCwKdKOj/zSFKO7OBOMySpOZEqQ6qdz
	ogj3ZB8T26A6SNv5+5zhH1eZlexYJ92mJMTQlUdbHx6hSKNom0=
X-Received: by 2002:a05:6a00:c58f:20b0:872:b1f1:aa8d with SMTP id d2e1a72fcca58-872b1f1b6b1mr3412956b3a.14.1789573428428;
        Wed, 16 Sep 2026 08:43:48 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87200c58282sm1508935b3a.15.2026.09.16.08.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:43:48 -0700 (PDT)
Date: Wed, 16 Sep 2026 08:43:41 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Aman Sharma <amanrsdev@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, amasharm@redhat.com
Subject: Re: [PATCH iproute2-next] ip-route2: document uid parameter for
 route get
Message-ID: <20260916084341.1a393857@phoenix.local>
In-Reply-To: <20260916105759.742997-1-amanrsdev@gmail.com>
References: <20260916105759.742997-1-amanrsdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:27:59 +0530
Aman Sharma <amanrsdev@gmail.com> wrote:

> The 'ip route get' command accepts a 'uid NUMBER' parameter
> to simulate route selection as if sent by a specific user.
> This is useful for testing per-user routing policies.
> 
> Add documentation for this parameter in the 'ip route get'
> section of the man page.
> 
> Signed-off-by: Aman Sharma <amanrsdev@gmail.com>

Applied to iproute2 and added missing SYNOPSIS item as well.
