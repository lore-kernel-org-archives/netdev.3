Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B5F3F4822
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330327; cv=none; b=rBXwa6ghK9AAEm2YlQNZVN8A3BWmrbdRHkaM5PCbPm03kKj2TG/9OdL/NIujhpo9LxHbzz2Y+gaf+qFCEnj/X7KQHVl9HGpB3UnvIU7jL6rN/gIj+PWaKBVsDPrllfrhbUqYWrFZl8lbdc0/+QYSf/QRm9MFQY5OEYiazA5j5hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330327; c=relaxed/simple;
	bh=AW5Jo2PZ04jm1iYTwzobVILZM6p6estGxZK0l+xeoyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvbCkdKEEpXIJOdxbxPeIXYWW39AHNJZlrrBYm1YcIaTy4ukt5dZsanuuStbT4IQLDVJpI2Y4OL+qdxBXfxiq9QH5p4L92C32t65+Y3DfecvW0lNEEirqXjXo1Ysq/s4dOCnKfdcg9OpKyr3I7orp6ypLWAvzuMw5n10go+fUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4OLTfO5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jf6RzTUa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4OLTfO5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jf6RzTUa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783330322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/S6VjjAq2bjAFrTzcZXWjqla9iifhH1rfxk58mIeTo=;
	b=T4OLTfO5qPMh68+H4f7n6UrPD8sHzMkcIjugC+Ig4zi/CuT9fn4HYc51V4QtRXv/AQRpQY
	RsMT3XDdyjp3/olegNfrskX5mmjxMmyTmIMiHFvRXoU2MqdfhJePkmeK1457ZHtIoP54nh
	Os0je+IS2TrMib3GaQRBdjv5s1a5W9c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-2CGuY5ioM2KNRkkQ8GAKMw-1; Mon, 06 Jul 2026 05:31:59 -0400
X-MC-Unique: 2CGuY5ioM2KNRkkQ8GAKMw-1
X-Mimecast-MFC-AGG-ID: 2CGuY5ioM2KNRkkQ8GAKMw_1783330318
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493ce08a6b4so29374315e9.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 02:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783330318; x=1783935118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y/S6VjjAq2bjAFrTzcZXWjqla9iifhH1rfxk58mIeTo=;
        b=jf6RzTUapDI412/71MYf9lDH+JIsJIe1xf7cD0leydPRt7hQ5LrFsFvqsdErato4G0
         TqZVWMvCcrv3Ah84miW00SCkmgtXDa1feT9E0JbRW8Hy3IaHmtgyPmDCoUXoGx5eXsGO
         AOlXy669weQX7b7sYSRw4bJyt1fI/AKk4utTTTdONLywYooebcZBunBHDwzGz4UlJAii
         SWRFMLnLgbi4sfGs8GGJEgiajzEnPxtyvxCoY+FIma21ZsXlGrgAY5Je5Ve/Q0P+0Unz
         ZUT+6T4TlkTihC3XcpkS028ykGBrMAk8VYtPRR7U8WetYSrIdzxDiPXcKN9Alh8H0PFJ
         a3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783330318; x=1783935118;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/S6VjjAq2bjAFrTzcZXWjqla9iifhH1rfxk58mIeTo=;
        b=hbHDk2imdhy1bXd5MRB/AABn5eV3swQKqVpSxSWV+hRtNmSSfr5jU+XLDPL5i6JVgT
         /S72a1Ii4TmihbCX+dfUADW4FaqHjwO2fBS6WkHP5UOeaCTlBFjzd5h2An1NmuLZ3CL1
         X8dv0MtrF2s8EzrCGWbR9w3tmq7Yh3rPl4/XpRexty2jVO0jUEkB1m1xMEqELvheLf2l
         /uqVdWm8HGNZFCnHzfJx6lBg7UgpYrd9bKjO6hIpk03737E/NilrgbKjlOpE9qyxFxdo
         6RY1rVIKsMpMW84VIFbJfpFdClUuB4073EWNmooUVi8viNuywQxy6kP9qQYQzVX6D+KQ
         +tVQ==
X-Forwarded-Encrypted: i=1; AHgh+Rod4bYlkvX0+q11ETmaYA0Gm6RLq9czGgvdHleemvT4AYddoNN2pSd++AjY4pZomE/g/MJMt7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzPsLulfp9TNlaFbTso30NrcJykxoknztjK6ErZWwGhE6t0Php
	74FU77S3RxctKpuGkk8VSPlGI53PlV3DPeDL+99clJPZESWKPeOJDrB8IC6Me6EJnLNJIozf1YC
	CZ6FRRrwxmvve2NKWTQPVDLJQKBbieCJo5INURYsLTUjZFb3AnbjvRJ/uXw==
X-Gm-Gg: AfdE7cl9QN6586N4RxZnhy8A3gPijxQkP86nnulpMhK9k7RJVlHazJZ0ke7SZvXF1qH
	oo7lx7k375aZX54t9+20jpp51HGLkp+5sYdd/Xq0P/L2HsF2DYue9KgrgKb6RfnDvdkNpbgK3ir
	IgaRJtZI+60EVn3iXxjIjvJPkCQwehIe87HVWoBce4pnceidVRAaROB8UvoHX0bxqeK+MdHNTgo
	tOr6DdZuQWoHs4LCXXgNJi6VoaAJzzl4ejMO5bynlrVw4TntjhyTJqtET4mUmWbe9fFYmUkb/x0
	aV1ydUHTpxRERipbabYyDy3/J9AZHV4EdRr0k2LbVlTaha00pTn27ayFfiVJjNnYPgHfEm/WfXt
	aC2OT/9XJRqERKiQmX9FwiAoJJUEvouCRBj1SWPIBiI2ShXmGBsIJ9HS7/NtdV34yC1rGxFJY+q
	T4weNlNY4aEyi5
X-Received: by 2002:a05:600c:34ce:b0:491:91cc:d12d with SMTP id 5b1f17b1804b1-493dea22594mr1060055e9.25.1783330318052;
        Mon, 06 Jul 2026 02:31:58 -0700 (PDT)
X-Received: by 2002:a05:600c:34ce:b0:491:91cc:d12d with SMTP id 5b1f17b1804b1-493dea22594mr1058685e9.25.1783330316297;
        Mon, 06 Jul 2026 02:31:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm23254178f8f.2.2026.07.06.02.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 02:31:55 -0700 (PDT)
Message-ID: <455c46ac-25cb-45d4-9cb3-5330f7b553c0@redhat.com>
Date: Mon, 6 Jul 2026 11:31:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/5] dpll: add DPLL_PIN_TYPE_INT_NCO pin type
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jiri Pirko <jiri@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Michal Schmidt <mschmidt@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20260630125536.720717-1-ivecera@redhat.com>
 <20260630125536.720717-3-ivecera@redhat.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630125536.720717-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/30/26 2:55 PM, Ivan Vecera wrote:
> Add DPLL_PIN_TYPE_INT_NCO pin type for virtual pins representing
> the NCO mode of a DPLL. When connected as a DPLL input, the DPLL
> enters NCO mode where the output frequency is adjusted by the host
> via the PTP clock interface.
> 
> Update the fractional-frequency-offset and fractional-frequency-
> offset-ppt attribute documentation to note that for INT_NCO pins
> these attributes represent the DPLL's current output frequency
> offset from its nominal frequency.
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

@Vadim: it's not clear to me if your doubts over the design choice
raised in previous iterations are still there. My understanding is there
is reasonable agreement vs the new pin type, if you have very strong
objections please raise them soonish.

Thanks,

Paolo

