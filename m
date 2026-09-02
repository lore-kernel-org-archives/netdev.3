Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F8339363
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373473; cv=none; b=tXjWRC/2VKl0SmIMCei+zikp0jcYKioF2aVnsC5c0ImXYBabyYFs/qTwY5hIQDAfWUIV6A6rt+Hl6rrHgpBGjLym6jz5RMiXS/nvHQQGRm8g02Gh9BQYmnyq3o2ejNbt48tcGypjrYEEeymDE+q6nclyG662mXk4HHUvSSAs1Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373473; c=relaxed/simple;
	bh=Xxq4o3qMxPVY2RpEIPpLOr1K2BMPwKY7wG5A7DWgTkE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=r8wi8Xcqj+NOKKyKhespUAVF05L0RxKKTelZrAtXi87ExGSQ/+OR4kQss51069HgXo22ACXrYzduGTX0swk7ZhLlDEJkAcTUSWg6De33BsHKSN0KIcaN31Tr5gLJ3BNqMWghc0sQNNlM+YzRhnTWfYhqZhfbrZ6XFZ8IFZk2nDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDkWO4xf; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDkWO4xf"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-836c8bdac50so18181227b3.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 11:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788373471; x=1788978271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=o4tO+LhSSXLcFLBaIQklF7txjQB+TEfFtyQ8FGsV04g=;
        b=gDkWO4xflN1qRgqekYpRBTSj8lDf9NN/HY2xr9zD89HVFMq9sJz48+nwIOv6EHOUb8
         3o9AQ+WN0691lVyJmoDNqe0MS6NSfSYSZhwLvdvQW6ECCHcNAqSj766XSowyWWsNfDTw
         z2CzhWMQaF/oiYiXUk9ikmKLOAV0PM2BqtoPaMf1yRPXRL0BG6dCs2+gx8zXDvxe5RxX
         iyn6ydS7qrpuezLXra+kDwQbsnKR0dfP63POIpH03UN0niggYklCOf1klFMTnOzjW/ao
         667sUH5PFamOMHok8u6DuCxW6BvL7ycepjjOUNg9EaLWZGbCRwiwlfAHHEwoUSLI4EXk
         DLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788373471; x=1788978271;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o4tO+LhSSXLcFLBaIQklF7txjQB+TEfFtyQ8FGsV04g=;
        b=IWMIOp9U4dl1VtXCW4gPxbmM93haTtFhcfd8iJTRo58bRMD9MPvl3Ov304YmhVlhH2
         5/JoCsDE+C7yMcmvN8wDK1JFIIGY9TR1P4o+lhxUUAdHoJE+1TCmsdzKVhT5KmFdqCYt
         u8XhXHHz5OiUbTrmJbZ09XG3Wpz4Yji36wOYbCFbwFbKxtBw3+bT0aw/785Qw2udjmsw
         yGAT3P6XXZE0EVFnVobd5fYfMBjrplbYhqvIpSgdhQHVS7T58zXqSCc3nOpq9LDQhvYl
         Pmfa1ER7vVt5bdHv4DobjnxoMSK0rQ9U6kZ562gcF70S3KkP5L/5l53fUnL4x6uF+nXr
         JvgQ==
X-Gm-Message-State: AFuF++lYdQFLK56FZsJA+aTXB9y9yH9dt1MAX0NUOCcuc2U4KcqvIYDK
	4/XSFGeMw9sI0UwvlIKeIqKJlx4PzyPJbquEnnEGr6ZHpTO/cHVGVYAC
X-Gm-Gg: AYBFou0fnEs3Lgyelpx2TuEQU3NsikZck3zC6DDvLAbjBLDNhaWfUWNUrLZEZ7ZXBvp
	X9GV9MESkrPJTaedDuf/2K2dvfafBWrsQmvPcWhjWg9Bpj2bW0owC6O1abxdURn9eKxRQMLgaQP
	zQaMR1CHCZ4LnS3mABgX7XF5K8qfkF3gAYq8ZSKapXD2XG49ocpE079+L7somgoFGrYRIlKFhjQ
	lCKnHqTlY6IXceb843WafMeG8LUFeI2oG7OdK+ZeuqqYHUtY7x//qHLmysj0g/xGyj1jZPjCs+U
	dy9qjME4ppuDVrCIbBDk7AFkHgX1di3Pff+N73MpZoyNUBEJFqhxpxACx9P8gbESzSmys7+KOtN
	o2Ofjt92cHA5m+3XhuwX9kC1XJgWdeKMltosXnKoat5hAhI/rhraJb/KWL8x1EchI41V60ZWBbo
	O4zKRTBLLBA6cs734SyQUZuwXe6SP3qL/0TCabkd9SMytShaGiGtZOEcEnnxeZr2PmjUpoZjASU
	DekLdvGjlRsOVvHurUVtp6LGmdLuS09w70I5jZQqA==
X-Received: by 2002:a05:690c:6d84:b0:81f:4247:de16 with SMTP id 00721157ae682-86c531a09b7mr24943487b3.24.1788373468198;
        Wed, 02 Sep 2026 11:24:28 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c17841618sm23311307b3.24.2026.09.02.11.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:24:27 -0700 (PDT)
Date: Wed, 02 Sep 2026 14:24:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 willemb@google.com
Message-ID: <willemdebruijn.kernel.6d16fb1b028@gmail.com>
In-Reply-To: <178833338726.3394541.13779692240559712632@kernel.org>
References: <20260831210128.1359978-1-willemdebruijn.kernel@gmail.com>
 <178833338726.3394541.13779692240559712632@kernel.org>
Subject: Re: [net-next] selftests: net: csum: filter packets by source address
 and port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> =

> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
> =

> - [High] Incomplete fix: the patch adds source-address/source-port
>   filtering only to the PF_PACKET verification path=E2=80=A6
> =

> =

> Would it make sense to also connect() the receive UDP socket to
> cfg_saddr:cfg_port_src, or use recvfrom() and drop datagrams whose peer=
 does
> not match, with the same cfg_zero_sum exception used above since the so=
urce
> port is computed at send time in that mode?

That's a great suggestion. I'll add recvfrom() src verification in v2.=
