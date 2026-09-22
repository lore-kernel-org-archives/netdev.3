Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ECB364EBF
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790040670; cv=none; b=KLQz8o/F+aXGxS7Thzlb8qozdE6owlPSVVxX7TX8vLazw3F4mN41egA/z2+APsoNR8aq8Au6DplUwD3FCVgPSE9qfIk11oqzvpxjZJ70e4Og9b/yscs9chi3KvSdp6sNdRNob4jop4zxwYUe4mFvTVCbntIleeVCyUlTmHphS9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790040670; c=relaxed/simple;
	bh=pLQIzyAXx9BXS4Jj3YBYF1I98hZkelIy5fkVP6OLqRQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=pyE+sTPwGysRuzqgoqQAW5p8rY/XEdtLH7x/2eiIkl4NX0DZyooMJgprfJjX38EpPj1KWKh8dGX9CH9ms2ptts+bbOTgM3kIyxG0kuNhKEl7Ch/4SfOJNbVMs88PfjSEJ2E3vi1Czm8Oud267LAr6L2FfcdakXm/YrneNC1oV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XatlDfpl; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XatlDfpl"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-66e4aae3147so2623287d50.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 18:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790040667; x=1790645467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xZPM204BsQkvGwo/0VKtkWmPTs7CeisxuHS7DMwf2J0=;
        b=XatlDfplU5jxFj8s/qAjvIWuO09vLiCrFRHLWy3G3OMxOBIlmqsKvCBweD5Z9x04J2
         fHbLptA2LTwou8yktuWkEmPJSoWtG80LZ6ZpJusja/SCSJ0jdI+5mqQPCo/VpNci/MV+
         VeFWKN62iC/IhUG4gwPS/+JXebnSBmbCT2NNJHZ53ty07r886qGFokGjnbm9hXiQO+hE
         vo954ke5JmAezi00JegrecUtgblI0vEvvsqSSR9AAcmQqqbKma/dNAPj9rtHUA62ZaXm
         uPeIlBly1lbF+3rx9s6jm8rAi+4ZtVF0wFzqtwnxQ+45bycnL5jymiM9vrB8hz8uqYc6
         Fugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790040667; x=1790645467;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xZPM204BsQkvGwo/0VKtkWmPTs7CeisxuHS7DMwf2J0=;
        b=OQqHPUhal36wGzaCR5EmgPClWiJpeDAs4bQSkpNdEuVi48MXUNc+HpIeh7TkIJcHK3
         S2eHxzv4AbWPcZ2zr9mQ7cGfD7Rwy28rViJW9R6gstp36lek7aMReOoMcA63kctyshk/
         nDQPxeQkQ7B+cIG8OMSxEKJ3rFkrskr3yru86AC3JsVayCwnxsrv963PdP9FiSBYJ4HO
         yStLiFjGQanqL27TL3w1yx9FT+z+7FeSzW9Y+w/bH1JBAkdS4IssYdGoiLaNegVKdbX3
         hDnZtKAG8lpQNbHqXOtOKvswIuDbTsg6HOSIUlZ2qWzoC1eFaparGQr/2GyevcnoxPvs
         2HAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPIziwLZOqvsvmvo5WwXhBlaEfm5n/zXvA5UrZX/K5kn9Mhdkd6VpZ1LfRZMZpLW3EWZpDQzI=@vger.kernel.org
X-Gm-Message-State: AFuF++mfhXX+7LEchILm1C1zRaX3ZkoVvQeFdkFZcDlE4i5NButfkUe9
	qqGXvIHsJ9DFf2cFMbhMJPzSX8qz2w/OlpI2mwaSSrRfKBVFHzxe8Mj5
X-Gm-Gg: AYBFou1uMfwVD8k9lfg9zG4Iaotyu1dx9EJa9ST7eoBCRs7heYakC7HEP86EVySBzvU
	6jmwS2DAa3++Uh7ptUVPNFMz+cgebre1vZjGPkIi3ZRZ+IaG851nVhlYXKFRZODvHfFmwxVYhHA
	0U0AV0aFpXX4/GhHV5geh1A86yuE9YckC5u7h+4D0uDeALtmpb29XxqmoZKDQOUT+7iKhF/HuAU
	px6Jwa0y5SfLy2w7+pFUmPcJhii/XM/SlPg01LWGY+EKVeXyb93nCYz14TYzkiPSePoO9Zf72b+
	wopTBgGhZ0IsfSDkWTNY8YDhr5sysoy5mhLbgroxBZlIte+Dhu7gXCl+MXREeWw5O941G8mdY9F
	8wEmcXbUUlkzPEf2nD8uKTyUMUDIqhKYIhFWeQryDn3BdJ5BQQU57TFwTHOWw4vgAkWIukBXaAg
	pd3OnucQ7aE/2S2IEgiDmer3doz889ARei2QL7wWpVbgJUUUaWueLBxwBQqha585ebtv+0kjjlh
	6vw2JSQHpu0C69yOlIKLi4zlq1ixJV79iz7mdUUGXeWxwWjwySp
X-Received: by 2002:a05:690e:138a:b0:672:a83b:9964 with SMTP id 956f58d0204a3-672c199f5d8mr821945d50.38.1790040667423;
        Mon, 21 Sep 2026 18:31:07 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672c766dfcbsm157903d50.17.2026.09.21.18.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 18:31:05 -0700 (PDT)
Date: Mon, 21 Sep 2026 21:31:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Jason Wang <jasowangio@gmail.com>
Cc: virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>
Message-ID: <willemdebruijn.kernel.2e1c6881ed336@gmail.com>
In-Reply-To: <20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de>
References: <20260921-v6-7-topic-virtio-net-ptp-v3-0-3350851c4f88@pengutronix.de>
Subject: Re: [PATCH RFC v3 0/2] virtio-net: add flow filter for receive
 timestamps
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Steffen Trumtrar wrote:
> This series tries to pick up the work on the virtio-net timestamping
> feature from Willem de Bruijn.
> 
> Original series
>     Message-Id: 20210208185558.995292-1-willemdebruijn.kernel@gmail.com
>     Subject: [PATCH RFC v2 0/4] virtio-net: add tx-hash, rx-tstamp,
>     tx-tstamp and tx-time
>     From: Willem de Bruijn <willemb@google.com>
> 
>     RFC for four new features to the virtio network device:
> 
>     1. pass tx flow state to host, for routing + telemetry
>     2. pass rx tstamp to guest, for better RTT estimation
>     3. pass tx tstamp to guest, idem
>     3. pass tx delivery time to host, for accurate pacing
> 
>     All would introduce an extension to the virtio spec.
> 
> The changes in this series are to the driver side. For the changes to qemu see:
>     https://github.com/strumtrar/qemu/tree/v11.0.1/virtio-rx-stamps    

What is the plan wrt the virtio spec? +1 on demonstrating working code
first for feasibility.

Does this now also need a spec proposal to virtio-comment@lists.linux.dev?
