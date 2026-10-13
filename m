Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5693CB2D4
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899283; cv=none; b=bp+YmIEtJVkVcPZBbOB2QMpqa/wsELKAn6VD96LWkFZLBrPjNkjFb2yQcC2i4qWaJpk+kOKFOerYCrHTv96nio4EyqtbSHadP3id2csa1hijYjiIGh37OTF+E2bHNd/Tjn4dnyMTmmIs6+/BwLZcwH6Ip0JnoMlab4YJCr3ABek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899283; c=relaxed/simple;
	bh=REg5Mntcb+tsmQNtdHglZYMVn8Nwol6pChdRnAFVNkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ep1WrYh4qUmlIv/qFH+1w3KHxXOyqxZE5JhqJI/5Mb/pBrCB/t6aZVGrhKciujyvL9YQHhp1L+EoW6zi10nMJOK8frNDocP/Arw74zdzIVoRXIXCv4yh+RmFyqL5Zi9cEgigF2iNSywSqxRXEpNeS+ro4UI5U7lE/GFhjWDRpiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QGSXWaZE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KreR4oPM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGSXWaZE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KreR4oPM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791899281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YgGQEF0Pnm38fJNWvw8gvjA222tZmizMgG6WO+7xu+8=;
	b=QGSXWaZE9X9VrDkPqWtT9FSOG6OIBx/FuFc/LvSTr1rV7SflkcukbS/OECe4ZMxwCkChqD
	p4zSB5bi8HSY+cq5FkDAtfEskw2xFLkTkQAgSqxOf82SmnJtk6f/7uHZXxwYm6E9hCezHq
	XWrVbjXEc2Zd3ktLPutrfbfJyNFUFhg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-Ole27nEnPnuVFtu1ALDQaw-1; Tue, 13 Oct 2026 13:48:00 +0000
X-MC-Unique: Ole27nEnPnuVFtu1ALDQaw-1
X-Mimecast-MFC-AGG-ID: Ole27nEnPnuVFtu1ALDQaw_1791899279
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48c46582442so1969525f8f.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 06:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791899279; x=1792504079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YgGQEF0Pnm38fJNWvw8gvjA222tZmizMgG6WO+7xu+8=;
        b=KreR4oPMlzeA0zSZnRmCu3+uNiACc7J02qXHHcbrVfGaA0nN4/L2X+KtpS6T8de04f
         BjIckzJrTgDP1J8JUCueZWKvjyiGHBJmVLmGSmqNM2l+hajdR9TNl9/tZLvoM1iAEp1W
         EF7N7G44nH7c0aQXyVPurYyVkNt2ylKQWfe2JY9GG/zR/kC/XVPOjTU4aNIs/3+BZUTW
         JXn0M1aorNcTo5RvKE2VUdp2TzeROyaEJWXP0SjqEt2S0XKLq+BjSOVRZqrHlueUHdAF
         oOcihgJupZ65XRipFYuMyyZRe+U14RydMdak3vKdn4w2ursn6703M756EeJqAnH7d4y5
         32sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791899279; x=1792504079;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YgGQEF0Pnm38fJNWvw8gvjA222tZmizMgG6WO+7xu+8=;
        b=QyW/qybe7ReW7df5ktTToN/g2rmp3WK+TptXJGKpdOTdiDOUzQYJcarh9FjcfaVdhm
         U5+XmrsxngbVJSTXZWM+3eYziCWe0sWZwpurqfvkuR63XpPgMOGklyO/5bFfiRpyBzhB
         e83Rm+nox3W5QsuaThcgg3jvdSXfR1jMlWiOufYv7u3sM9WwTCQegyUaAQXov5f2bRpy
         c4J51wUTfNRRc34WdPBEgLtf2KeSLmBgan7rklRBuBzqK4LplsXJetM/BtK4OFPTgaRk
         rLJyQuwQequ1LTS83OXM7h+ph+WLz1H4NnT5f8RDld0SBdzeBHmKj9ByrkVB3pBo80Hs
         /2GA==
X-Forwarded-Encrypted: i=1; AKwUvBx4UxDkJ7Qe75LOPg8Yk80sAbSTNOj0H/zulnBPKqgQ/xwwkDYPk1MCLzlcdUiswYdbeQio6cU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPHCyJYZrkPjsJoroa2RTqtBQ2POJ/7DOHGpWoRkV0ag5CaJrI
	znH8HczkuEGTtpfPwGJp47xW+1wgUm7Y3uX+9JbRsxxO6xMPy+elml8HRxFHKYCTzOInURurm6I
	98X/PvbYO4CTTXetNjo/a8y59NzKkw3pIH/XKDqXUfXrRP67cZ0UZ+XDn7g==
X-Gm-Gg: AYBFou0Fo7/F5raRph8Z/055w09VJNGx5KoxA6+hG/xP7Xj7NxIlQw6dlaAlI+3Luzs
	zovcRz8ypGNEMVHGPEAZfbF1nahXtYHhEGam8rG5M5wkbgQZDbWIS/gO7NGFGk2A2K/7iJstlRo
	LF2jdG8WIUad1Q0/mEazwbcI2uAQ9DzRlGUP5qEsTsq/o9kYL67+InyvxLo1zgAOUsh2S8Tc6ne
	oEqacHKx5Zs7Aff10G0cUPbFtEvdEXgqjEm3HYa2y3tesUtHdyVsrfzg77VjSH5PVNk1/zcZUVv
	mOLQEyQILGl818WtEDnoeHGYjuHYswIW79RtAh8OGwpf/aQiygEmSr0TlHdEKVu0YM0k8IEI0wH
	KbWyZD6F1YRc0kuEH6Ph8eWqVA2hwQq3Dd44AO7lC50r1ANL1HHXoXma/cCimZkau7pRZYlBl8g
	==
X-Received: by 2002:a05:600c:3b8b:b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4a18e4a7cfcmr308259075e9.26.1791899278734;
        Tue, 13 Oct 2026 06:47:58 -0700 (PDT)
X-Received: by 2002:a05:600c:3b8b:b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4a18e4a7cfcmr308258425e9.26.1791899278275;
        Tue, 13 Oct 2026 06:47:58 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc85b1sm4979371f8f.54.2026.10.13.06.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 06:47:57 -0700 (PDT)
Message-ID: <8c40f576-08d5-4b42-b125-abda8da2a335@redhat.com>
Date: Tue, 13 Oct 2026 15:47:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: alacritech: fix dma_free_coherent() in error
 path
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20261006140912.50828-2-fourier.thomas@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261006140912.50828-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/26 16:09, Thomas Fourier wrote:
> In slic_init_stat_queue(), a series of coherent buffers is allocated
> with the length size. The size is then stored in stq->mem_size for
> normal deallocation. However, in the error path, stq->mem_size is also
> used but is not initialized. This error may leave the freed buffers
> mapped, leaking a resource and allowing the device to access freed
> memory.
> 
> Change the length in error path to size.
> 
> Fixes: 60c140df15db ("net: ethernet: slicoss: add slicoss gigabit ethernet driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

FTR, bad things in NIC error path for old drivers is the exact
prototype of things we are actively redirecting to net-next at
this point of the cycle. Also stripping the stable tag.

/P

