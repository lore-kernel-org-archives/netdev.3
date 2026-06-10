Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C992F747A
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781101003; cv=none; b=GP2VOf1Hvb7IztW6nPiyEwe7dhkJNjIWt+qLlmhlESa0NtNa57qeLQTKD0KKsDOpJy33f5IJjr6l2XEIRtBTANPlEoSN9PN68d+dDngHwiyREVXVuhP0OqF1SpP/EoFiERhxoAUgRD6WINj2w05vipyVUV013Po4rfJzRzl6SZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781101003; c=relaxed/simple;
	bh=dC7rSCTHgGuJYfRNZEKkb2EY8GUvkSySC5H9koyXs80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDLlS3PL447Bl4jq0nj0sarS2TKeHrZXMDc09Y1fssxrwrKEj9YxHleGiFqjUp9vVwxgpyJjQLpTDPborFh5YbrhWrcWqzrGR0IlSzoChkQ5iOUGBZPr7oOjVJ+Gx5Bq5WKJ0AEv0TbQyqpq/Ana1e0d2C9HJj8Gl2Xv6+jKizk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcXTWyXO; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcXTWyXO"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-68f0fc103easo825012a12.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781101000; x=1781705800; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AArS6N+kZk+0Qh4KknxRi427XI5eU8WJM8cWH0zEIu8=;
        b=RcXTWyXObVBM2ZrZkig/0ZoPZLMYiYHPcIMcN9GBz/0EFukPyVaL43i3oe+LWKLob6
         lMdjpx8m4klsYqn1FJ4D5tF4FXotHWTcbJG590ayyzCuir8O3fiiES27dI+Di/DmSOtP
         NWurm/FK/yIpzXgzVGwHYJYYMt/hAm5xP0auCiUShSfCR6ATWjfBSoKbKw0DMddKzOC+
         xtC9PydP4WAmkkzqkIyyjzS3AW+3k2xP8WvByCXyeGf/CFAwqNV/aL6xM7zBzPMK/+w9
         MctQ8rhoNDGcWehUuo7W8ZRTBb9T2gTuAihNGO2UsuFXhVcdMhK5RsXheLa6i7HAaBdn
         dv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781101000; x=1781705800;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AArS6N+kZk+0Qh4KknxRi427XI5eU8WJM8cWH0zEIu8=;
        b=cV4YYRqp+/JDzrTTWtg9SZtqUaK7vb7jyUsG4FNoKsn7zmzUEWU1HsccY1vFwQOSV+
         495bK6dD5rPySObVGQUJoMmQSnOSEADwXCRjA7EAF5j4jPoWZly9zcaoKWjO2X3xt+im
         6+S5kOVCtew/jduU6hSwOAjZFo++6h3TlsbCb2lQ84ze30b/QBGpykuGnOUb3h4k3X0z
         IXC9isbUwC7uoUX5MlofffB3+Yn5SA8vlZVePZO4EmzB9g4WRWqabUiFFmV4IMyqV59H
         nhLDfY/QR7jjfTEq0ig9Q8j5+sP+LQvIlG+3/Qp63j7qc+CCFJLtvPEc6eAXElUwE3Gk
         NPmg==
X-Forwarded-Encrypted: i=1; AFNElJ9IOJ2KEkVGXEWFerwv40zOsNCd2sYp4vWIMA4/tRHlyoi65DXipYGMxzuyYMAUyNjR8SNgTfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOt4I+TisQZn6EBplR7TIGGkck9ancxjrMYGmldgnepr9WiIe1
	sfcFXrZDBcw1J2mhC23E1tEnZTG2q6WkUeHydMVSBLcH9J/HLhyXKMCT
X-Gm-Gg: Acq92OFXVJ87jOOcNdIgL+G7Ejavo+8ZU4jpYM8fGGm0PPcwakq0yuMVouBWkLJkXzT
	qnMdc6uqXSaJPLSqa/CMIwU6uTjAPfVvwvO2Ga54OHieQOIDXq/m1Ncz8iXkBSfVzsKSkYdLVWC
	GCRnneQqVFZIqAna80fV2ya5XlnwkZ2wep+92jfBEGwFs8J4kt1RhTmdt2i0CQRWzp1eu1sqmM4
	Mnbcjdr6OGQR0hnIh0xzVfpBSVjsF3f0pe/kUaJTYOttuYUyoKLKPdlrrQ10kEx1dJfspOqxiUi
	gA0fAWzQhhAi4LJRhBDsk4K8x/JBJHakKAQqOmStn9TQaZf8HsXEDpdSAtEX7y2M0GI52iC6vj6
	YRa6LE0pCczqQV+ZiRfaa46ow1QyK7HvyHRNQhWl+OdMd2bbYg8sMOL79k9QT320eofQ8++xjx/
	31iCphLqfg2kPd+RbxblgvdujAs42f5wM=
X-Received: by 2002:a17:907:75e3:b0:beb:c327:8e7b with SMTP id a640c23a62f3a-bf93a1f9f14mr140419466b.3.1781101000167;
        Wed, 10 Jun 2026 07:16:40 -0700 (PDT)
Received: from localhost ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559f1f97sm1228195766b.60.2026.06.10.07.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 07:16:39 -0700 (PDT)
Message-ID: <85eaf82a-28bf-4d3d-958d-1225a7ae9608@gmail.com>
Date: Wed, 10 Jun 2026 16:16:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] tcp: support non-GSO jumbograms
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, pabeni@redhat.com,
 dsahern@kernel.org, idosch@nvidia.com, ncardwell@google.com,
 shuah@kernel.org, kuniyu@google.com, alice@isovalent.com
References: <20260608130755.5626-1-maklimek97@gmail.com>
 <CANn89iLjG0krEoEE__3KUrcK+ZO+USZRC_2qZV5hAsxRpkTmhw@mail.gmail.com>
 <715cf429-9f2b-4898-84b4-15dfba4a9a8e@gmail.com>
 <20260609152704.2512ce9d@kernel.org>
Content-Language: en-US
From: Mariusz Klimek <maklimek97@gmail.com>
In-Reply-To: <20260609152704.2512ce9d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/26 00:27, Jakub Kicinski wrote:
> On Tue, 9 Jun 2026 19:01:02 +0200 Mariusz Klimek wrote:
>> I understand your concerns and they're reasonable. I would still like to
>> proceed with this series, though. What can I do for you to consider this
>> series? Would it help to submit a few less-significant patches first before
>> resubmitting this patch series? Should I resubmit it as an RFC?
> 
> AI tools changed how much we value code, but they did not change much
> about how one joins a community.

OK, I'll start with smaller patches to establish myself more
in the community. I am still interested in eventually getting this
series through as it can speed up workloads relevant to our company.
Do you think this patch could potentially be considered down the line?

-- 
Mariusz K.
