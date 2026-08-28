Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B90368950
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931374; cv=none; b=rQO+BvQlolU2at8J/z69j+kJ3vwyVpIvZJtzgOd0cHuvBLRDz509ALme/YOg8rHpz8e5aArME334AxoP8HbnolJbr9En6wyrftwirg/2kpIOTdUqLPMqZf5VuRcLE0NuC6rsYjv/srykv6RP0FgSng2hL7A+LrHqcjnHISEovSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931374; c=relaxed/simple;
	bh=gnIzB3ULi7x5ONQLDvVTUDoIOX1PzdODHvT44xCkI2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWB81CkhysuVcAJTzDesGPT1GVXez7J3MKrowunwP/3+3lGQY4H3p1Ef3mD7fjIzmsptD/kW+JT/qDnKjoGSBos9AAR30awhYcB0fCVtLoPn9HnAKyYM9ho7CiVnf5na3sFJwm9q9Y47nJxFNhPX+ABTb0nMa+UPjQVQHumtTKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apD7kXZF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apD7kXZF"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-482dd6ee390so976296f8f.3
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787931368; x=1788536168; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1orVkvfwH46u61Ql1Gfh2n9UOhRS6qwriTQ/HzVy+pI=;
        b=apD7kXZFoOUaQdhNp5kVLhMC1C5fLe/uXaVXCts+YHrdQoNmfMHD9BOfx/+nC4Wipc
         A+Q4gD2VNfBXMKF7SxZmkq20bexsvf6DTcSTyLf7/+B/JrC77EfFs5CJ85W242Z++yOF
         j5TWc3g3qtDHYO+Hc3ocnqp2w/gPpifvC9zractrntZFW+DRTsEx2wY4dNxyrfEH3KII
         9nDpYFU9bQo5iy6C0ZUjMQlh3lqPFCGKm1McB4+tRtixM3b0iK17wXa2DdFDX4UAHtDh
         GUC8HzLih9SjSAYTlEs8bXsAVIcQlXg8PgZsini4DCP5hvUjAC9nHMcxU+15ezGSnI+d
         TW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787931368; x=1788536168;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1orVkvfwH46u61Ql1Gfh2n9UOhRS6qwriTQ/HzVy+pI=;
        b=IGlN8U88Pgkf8K70O+t4VAq/enE6Kbaip+x8cOkvj2Oc3GQYmHoMPIQ9XkLaXotPFf
         sCM/C42mOQMyB/RwUVuTNllBPC/NqOjGva0JZrryRzNG64cX7iIxSXLqJdrnmwRYLwLk
         3t0UiYhp57hE/Zigvi0zK3kDCnb+8pqi9qzycH5b3tQImXyeTD9sR0bBbSzIMfJRHxpW
         E9byAb8FcuPRR51lBLAol5FKccXYc+S/XiRnqqZy8PqRBtS5UJbXiu3EU/mmCLBQjcA7
         7Jqng/yxhFIH3wo2ZJ5ImxlR+nUf6Bpq2GsoCwxDWqglVficePDmb0BCNI/OD4j11Lhx
         PTcA==
X-Forwarded-Encrypted: i=1; AHgh+RrqPRUsAFtPlvKlHf7ZawZqVbq4oaxsxdsurHhgT3kevJzTByvZ7PAsALgYrF+kOPkoK9zP5cA=@vger.kernel.org
X-Gm-Message-State: AFuF++mSlYUlM2grX5E2j7AM3izCvgeKLLZPCfh4fjFN44HXMal7UXgp
	WMGutWBKgwjuQ6Ar29TAL/Oe3qegZEhJeLEQXFikDPaNsNUi03pyVSCk
X-Gm-Gg: AR+sD12Qabb9gwTbqly/hXd49M2MXz2qzpjx2xa5jje9m+LXP9edn8CxI7lSmHofU7M
	rCEWBq10PHSSkN8tc0S3ne+BHZPhwO+GyyZBbCUNNZu6MTeA6GyLb69N8B/hHd7jNFGPTsgDDCt
	dlWvg3rXYIwS7MCcQBY0cpfcF/0mS7XlgOGRw7a9dy9U1pFpQJl1t1KRJ+abiikTZLKT1GOG21v
	ojRhYVnxvnLHCY6q6a8cD1eKDRmGOm1ODKe00xcMuDGR5gMHfsO43o/yAQJpDY1OL5MhHMIl4ds
	U9zz0K5HupLh4Y8xn8leNbmi8Z7c+2m7hOwZk6lOOvvFM6Rs0hD/UFtx7gjgUNqZZNCPG9mr4X2
	bt1x24vuT2DIGZfVq3gpaWrGKodqiT5AiQxIlYDqJrvbIKnF0k9W7NFPFD04fAGvFmO6lPJCako
	6+rm0qoEzkB24wgUmuOQawOHZggEPmYgf5POxmtt/Ez/QaHcmUkQQjmwEBYsiy6Tx7U1OTyvKjR
	YOgvg38Ivtx+GI=
X-Received: by 2002:a05:6000:2310:b0:47f:8183:e9b8 with SMTP id ffacd0b85a97d-482f79e1e9cmr10847640f8f.22.1787931367551;
        Fri, 28 Aug 2026 08:36:07 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbac8e61sm4800483f8f.13.2026.08.28.08.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:36:07 -0700 (PDT)
Date: Fri, 28 Aug 2026 17:35:44 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com, Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 6/6] landlock: Add documentation for UDP support
Message-ID: <20260828.942ec705ed5d@gnoack.org>
References: <20260611162107.49278-1-matthieu@buffet.re>
 <20260611162107.49278-7-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611162107.49278-7-matthieu@buffet.re>

Hello Matthieu!

On Thu, Jun 11, 2026 at 06:21:06PM +0200, Matthieu Buffet wrote:
> Add example of UDP usage, without detailing the two access right.
> Slightly change the example used in code blocks: build a ruleset for a
> DNS client, so that it uses both TCP and UDP.
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>

Friendly reminder, would you be able to transcribe the newly added
documentation into the Landlock man pages?  I added a tracking issue
at https://github.com/landlock-lsm/linux/issues/66 where I outlined
the rough process, which is mostly mechanical.  I am happy to do a
review.

Thanks,
Günther
