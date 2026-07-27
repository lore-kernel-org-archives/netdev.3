Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C3A3DB640
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785141224; cv=none; b=Tjl2OpzAImAabpAc/ZtjF4g5JoyGIYLDMYGoTBzK7pGc4yl0pY4aX9Bw26Ld6A0F1hwMCO0wCjpi+wPPn4I8j5LwC97ZyqCYLqpniEUF3dwwcFKB/BabYkJQEFjDBWnQKGk3YPvFUyhwMQeDiDLvQdElV4Esn5x3EGssPaCauTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785141224; c=relaxed/simple;
	bh=vItblvgfl771l6T03eaH12cXJaJqN58PtreIg3qHjGE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=I0hIYp6wmedDDR10amjSX5HULXJkpc0jj/szZKB+bJ9tfFHD+UOedpshwYZt2At7+/FoZfPx+dH1sxnJia/8Rc25R2bET8EtBrss01EIuVtHh00xrEcDjMiJy4uPuH6GKY1uOSKkfvp/Ugwe9HCZOXTWKvmPzDHSo+x1+emZVaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CP89s9tt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SNoOEvtQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CP89s9tt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNoOEvtQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785141222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SoIqVFnDh6l3DifH8XTPuu7I7xh+xKAJmcsEd7dlwco=;
	b=CP89s9ttFDRD64oryp6xfOfsRaGLUoU26NIoC4dFBriTR3G1J7j7Ym2h47NbIVCPyioQkC
	Yy4NfsO7HDU8wG87he3ZThbD6FvGEojB+wYkO4mkyPet4AKqWLAqAm8Jk8m39uOqa2l0E3
	Zdm9DyhgSu2SQYpoZwrjW0Y/r7FycTA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-CnA_l0cAOXKM0VGD6ij5ZA-1; Mon, 27 Jul 2026 04:33:40 -0400
X-MC-Unique: CnA_l0cAOXKM0VGD6ij5ZA-1
X-Mimecast-MFC-AGG-ID: CnA_l0cAOXKM0VGD6ij5ZA_1785141219
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-496c06ba017so2748655e9.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 01:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785141219; x=1785746019; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SoIqVFnDh6l3DifH8XTPuu7I7xh+xKAJmcsEd7dlwco=;
        b=SNoOEvtQfX9j76csCSpCklVD4M7OA2+xWM125KrnNxllPDwtaAakY7CGlQuSNITNTC
         KsRAxyH6YwrTGtW0qSLEjS3NJeF8Kx6F/Obyc8RHzbwPqB2itVMp9U9q3kYwWomtx1o/
         cwH6YHrjenl/8qVOYVb4itrGiKSTZHZE1srjA0GLyITv2ori7lch9zA2QGMGxs7zF0AS
         MBcLeP2ffS5Oi6pVQ/Ko/XljCTAk6fB86fKwxbUhhwC1+Pzw0txfYIombplATBb9Ifcm
         gI7cRggLHjHP+7LRDpWIayVg+rpPlVjTEvPq+RZhu+EQyWTkQN4VcwNVvoHJ4PY4AT3m
         oI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785141219; x=1785746019;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SoIqVFnDh6l3DifH8XTPuu7I7xh+xKAJmcsEd7dlwco=;
        b=L66kNjJYFSnnyFjVpK0GSoNhYmC/q5+lbKvDQQgdnh23Y3aE8i5/+Wl3GqO0vT49jD
         0c4Wuc9Umbpb+YprKdYhphjg9m6jkJFRg4br+kWPIn/koyBh2ArQ+efGdaav7BZIBAtp
         DE4eHgZ/WSXpZh92F9cJt869P+9jvmGenoIveQjkKdgfpiyU4XbZAHKxa/Gq5bNvZJhH
         g9AvcXahCth/xeWG82K3tIiShtWzyYuFBl+GJc4PHlrFcBJWhXDa+3+tAn/0b2sv0/RI
         ejCsr1AfmQosK36uA9YN6qi8H26fmFLL4xqhWQgBhk1z+rKcpdi7SMrtZ27UJ9+Dj9t4
         MEww==
X-Gm-Message-State: AOJu0YxZPzY93ui/0HEkmOgLHaGyVc8ijkn3IO6MSZbeKI24VTFOulyJ
	Yc9t1jeRejqfX+Symlg70Voyxc6Kx8dWemsG3YUmr90duKcS/TmJ32IK0Gl6o1z5LIqzq6q4J9S
	/ii4KxJg3fb1rctAmORUYPHiM4FiASezKclUO7wXttdtf1sScdG302nFwQA==
X-Gm-Gg: AR+sD12AjdH0peyo+Ex77x5cv2ER/LkBW1HyLbrTqlyoF1auQT3b/8J/d6URs5BaizG
	vxMuQ07k2qs0nA3oIMeffGzrCqGQKVfPxwWw1sIFbd5bZ7lwJjBr0fdQ8RM3eek8mN0ExIH+h41
	yUBGlkIfBg6cdcGA7tLGONjufzdWYdpMHNHK/BtpuZNFrHzpBXTmE4VUiVj0Rb3AosqDiFPRsDW
	zAvoUavmGOl7nS+ipSZ3sFw6Vlk0+UQHcsSS5OsXdv70T0E+hvZsbSMrg8mH8Ne1Vfe5mg5RHam
	qvQhxcVTfjxVQ2TMUcsF+nFPzRGZa4+2T73IfDRfvs79m1lOdcJZSE1iBCaXZwzRTJ5fV+Rb15z
	C0GqUMfpXHAgP0Jk/XQHm9oRo0zMbMktXvq22x1Dx0rKSf/S18ni6Ronzr3ddIm+jnTPd0ejVhp
	YOPcA11Q==
X-Received: by 2002:a05:600c:3b08:b0:494:1f7:8057 with SMTP id 5b1f17b1804b1-496b5b3af32mr91064505e9.1.1785141219368;
        Mon, 27 Jul 2026 01:33:39 -0700 (PDT)
X-Received: by 2002:a05:600c:3b08:b0:494:1f7:8057 with SMTP id 5b1f17b1804b1-496b5b3af32mr91064125e9.1.1785141218873;
        Mon, 27 Jul 2026 01:33:38 -0700 (PDT)
Received: from ehlo.thunderbird.net (host-87-6-90-116.retail.telecomitalia.it. [87.6.90.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ee4504sm205973265e9.6.2026.07.27.01.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 01:33:38 -0700 (PDT)
Date: Mon, 27 Jul 2026 10:33:35 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: netdev@vger.kernel.org, Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>,
 Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Pasi Vaananen <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] dpll: zl3073x: add PTP clock support
User-Agent: Thunderbird for Android
In-Reply-To: <20260722135848.2d401ada@kernel.org>
References: <20260713103739.1553284-1-ivecera@redhat.com> <20260713103739.1553284-3-ivecera@redhat.com> <20260722135848.2d401ada@kernel.org>
Message-ID: <B047A851-87E8-4156-97CB-117A71CDBCD8@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



22=2E =C4=8Dervence 2026 22:58:48 SEL=C4=8C, Jakub Kicinski <kuba@kernel=
=2Eorg> napsal:
>On Mon, 13 Jul 2026 12:37:39 +0200 Ivan Vecera wrote:
>> diff --git a/drivers/dpll/zl3073x/Kconfig b/drivers/dpll/zl3073x/Kconfi=
g
>> index 5bbca14005813=2E=2Ed0574ad571d3f 100644
>> --- a/drivers/dpll/zl3073x/Kconfig
>> +++ b/drivers/dpll/zl3073x/Kconfig
>> @@ -2,7 +2,7 @@
>> =20
>>  config ZL3073X
>>  	tristate "Microchip Azurite DPLL/PTP/SyncE devices" if COMPILE_TEST
>> -	depends on NET
>> +	depends on NET && PTP_1588_CLOCK_OPTIONAL
>
>Real dependency is probably better here?
>The Optional is meant for NICs for which PTP truly is a side-feature=2E
>

There are some chip variants that don't support PTP=2E Should we depend no=
n-optionally?

>> +zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch)
>
>Would be nice to factor out the code movement to a separate commit to
>make this diff easier to follow

Yes, will do=2E

>
>>  #include <linux/dpll=2Eh>
>>  #include <linux/list=2Eh>
>> +#include <linux/mutex=2Eh>
>
>spurious include?

Yep, will remove=2E

>
>> +#include <linux/ptp_clock_kernel=2Eh>
>> =20
>>  #include "core=2Eh"
>> =20
>> @@ -22,6 +24,8 @@
>>   * @type: DPLL type (PPS or EEC)
>>   * @lock_status: last saved DPLL lock status
>>   * @pins: list of pins
>> + * @ptp_info: PTP clock info
>> + * @ptp_clock: registered PTP clock (or NULL)
>>   */
>>  struct zl3073x_dpll {
>>  	struct list_head		list;
>> @@ -36,6 +40,8 @@ struct zl3073x_dpll {
>>  	enum dpll_type			type;
>>  	enum dpll_lock_status		lock_status;
>>  	struct list_head		pins;
>> +	struct ptp_clock_info		ptp_info;
>> +	struct ptp_clock		*ptp_clock;
>>  };
>> =20
>>  struct zl3073x_dpll *zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 =
ch);

