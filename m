Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EC3395D8E
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473948; cv=none; b=Qci+zLuJFWXgp8xY+kyav0K5+cyT6gATEuAr/eJeyJ4VXIudVoLofUpqelhnKLrUsAM931BkeOr09QT2eqXO24gUoyBI9HihQJ3gCa4icGGbDaSVBg/zmKviVgC59+fJqtdVrHQQZ9Zw3fyZe4/dSnj81vWZQtsvoVGBkUphx2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473948; c=relaxed/simple;
	bh=b3D6aCDccl7bcIeAH+oIcgZmZ6odBpA5tuLjoiZ+1gI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PP+IQTMjovbJZG6mylwVPitbxQtAYdYcM5oBGt2hoZ99QnQyGip6+878NRyZ2JDnWtRNyQSG0RQ9IxXdDK5GQXstEyEv9V1BokbsZjTv9uFATooFOF3uTLIG/QSFmnBfdKMPyQ3/7LaD2SpI1AxnCCILROypkPi9fvEyeSL8kPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JS09x7hz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tzkywPkf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JS09x7hz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tzkywPkf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789473945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gim/SVNBvgCpFfVOJRHqGbBm2NtyafpHF49tPtAUPvg=;
	b=JS09x7hzzOCuTk4v4bmKfduWXA0RVg7Cv6SQexOA0gImaPsYyAmuBt3fa0/MSdcZivGV2d
	jrDNC2X8L7nDR/uPAaqjMqMYYYssigF2BRo3ICTs7AwhlqXQXrjYBU6xJ/dWgBe5dv7uMF
	zGk811AliAIqSLMiyo0lWpjc3frnAj4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-h8Vbc_zLOj25s9rSxiECEA-1; Tue, 15 Sep 2026 08:05:44 -0400
X-MC-Unique: h8Vbc_zLOj25s9rSxiECEA-1
X-Mimecast-MFC-AGG-ID: h8Vbc_zLOj25s9rSxiECEA_1789473944
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90e8472ee1eso94121996d6.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789473944; x=1790078744; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gim/SVNBvgCpFfVOJRHqGbBm2NtyafpHF49tPtAUPvg=;
        b=tzkywPkfqAVK6wjO8ekbyesQ69LI03zcM17nvlNwyt84FZyuLvKyPHpIZTnGJ9E5Z3
         yD/XRNIzCs0EnOAF2jARggHcZGeASgA+wZMZ8ihNEbY/sOiX04RfYV4I760vmldtVOnN
         j8gACL2tZHfBDB0j0U+oxDFCO4L+qnsDDFYdMUEpaXzr3a6JqWvHWKt6adKKrClb35Iz
         aOKLYsnt3SzCPxuNlyV1017zI3VokJC0Y6S4QyyNMVhVLDgbQj7OcmbYGjp5VRFnZZZZ
         /rVWeziOhB2U4IfAeQ/BQiATe7mIhu423wUX43gw2T/6RdwFoZcy5yoThxATMidHJF2M
         pidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789473944; x=1790078744;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gim/SVNBvgCpFfVOJRHqGbBm2NtyafpHF49tPtAUPvg=;
        b=HHiwmwudEitp0tiF5vq9wJFJU65df77wtf6kDod5wHGRgObHpxvDxvbbz9GmNvJsc3
         jOQeDhTyKUbIHJnQZEFVn6h4h/TaVXG5Vpsa1SGynAs+JQUbpUT06W/S00tQVm/IrDQr
         FW/oa4rDfhLrWnLvijgPEL2jcfYR6ui6VnkIllJRgtoMx++XXfQiBf9xA6b3roI5Qb3s
         LlBsaYs/r+CaLtdkima1R9i2qtKaRM6i07XVH9VMtrAN2sT5b6vv6PsIog5ekqeigvPN
         ZbFH0MkfB2xz/9Lk/mqoktoHYoaK2n7bLvejzzENBZQzBTZW8VHehRKH9lhy6aMzXiCX
         ZItw==
X-Gm-Message-State: AFuF++n7Mcn0TldVl4hCPUtYn9gZzrfL8wdywlgMB4iAS/9I+0UMwLyh
	Aj2sOlIWNFbPmrtzforhdgMZzwJskBmHpg06k4hMGWL1v6I1Sg0jxs6STN7x4F8ycBKj7DoVKJ6
	RPy7xPKBxJ3iyKbqgVTinLTT/ENuLcS7+t6K+K44IDD660NBRevfDc4gMlw==
X-Gm-Gg: AYBFou2d8Vj+woJSjBN7dHlHXlyl4pVmn9c6W2PfYVWAY8NYVcrdDciQy6W78Qz+3vP
	u6DgE1j/uJaJ1l+XbnqaNhS1D45mIol+Y1O30D55dqQQURj6GI9LHa3tt+lOheXMFNH1RojQy1D
	/h3XPF/xsDBzlB+mVRKDTbb///TOOI3dijJbVqj14vR6Ch2v5L1wzO6qExTS2cGCmNnP+AxKQKV
	Cq6XtswRGv7AaHaczEFDZa/ZWV6Ti8vjssZwUV1vBwJXaaVsM+sYfxlRzZY8asSWJh5K88YVX6A
	4JX+5JBL4anE1paow93uXkp3ZOhGI0QlB8M6SY0fqzoy8G2NgsQ9Q3l7wvO/jbGIvfGqUUR+Mbo
	deklb0juXsQjWbp4IEqYIYEXQqQUF
X-Received: by 2002:a05:6214:767:b0:910:c44f:a81 with SMTP id 6a1803df08f44-9122e4e65abmr113520356d6.10.1789473943694;
        Tue, 15 Sep 2026 05:05:43 -0700 (PDT)
X-Received: by 2002:a05:6214:767:b0:910:c44f:a81 with SMTP id 6a1803df08f44-9122e4e65abmr113519236d6.10.1789473943147;
        Tue, 15 Sep 2026 05:05:43 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45adb3sm117732826d6.9.2026.09.15.05.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:05:41 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,  echaudro@redhat.com,
  i.maximets@ovn.org,  davem@davemloft.net,  edumazet@google.com,
  pabeni@redhat.com,  horms@kernel.org,  pshelar@nicira.com,
  tgraf@suug.ch,  joestringer@nicira.com,  vega@nebusec.ai
Subject: Re: [PATCH net 1/1] openvswitch: avoid reallocating confirmed
 conntrack labels
In-Reply-To: <372fbb062b40ae6723684f55484be86ff0064f8e.1789218015.git.zhilinz@nebusec.ai>
	(Zhiling Zou's message of "Sat, 12 Sep 2026 21:22:43 +0800")
References: <cover.1789218015.git.zhilinz@nebusec.ai>
	<372fbb062b40ae6723684f55484be86ff0064f8e.1789218015.git.zhilinz@nebusec.ai>
Date: Tue, 15 Sep 2026 08:05:37 -0400
Message-ID: <f7ty0d21zzi.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zhiling Zou <zhilinz@nebusec.ai> writes:

> ovs_ct_get_conn_labels() adds the labels extension when a conntrack
> entry does not have one.  Confirmed conntracks can be read locklessly,
> so adding an extension may reallocate and free the extension block
> while another CPU accesses it.
>
> Only add the extension for unconfirmed conntracks.  A confirmed
> conntrack without labels now fails the caller's label operation instead
> of reallocating its extension storage.
>
> Fixes: c2ac66735870 ("openvswitch: Allow matching on conntrack label")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

