Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A523330BB8D
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790626754; cv=pass; b=qfgh9Rr8sHOcE/A7Ax6Wrv9WKQKjE6jKvPyBIh2xCz91hS1ioDW8hZEvF/dzcTz4o+zs6CChd8pGoD2nEyYT7gSkcLTAZ70Iexhl6IpZKXhDLbfdxl0gy9Nonj+00pWmCEpvkSpKoxKcveQ2sArOb8W9tZ2aVayfDhdC7sIkG5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790626754; c=relaxed/simple;
	bh=46B2POKlbD/9ZIqgG3ctOki0bheokwhcbcExpv/6L94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSrZjAqKNL0Jj4792GA21j9Gw7cIvU5R1RsBAPGOK2O3y0xZEoXkvNNoSwoat+O4VjWB8QaWg80NbZ4driy/SNi2cfUVXfpXaSHZERZpBd5hqHpob3oJJ1GL3NeNsBKVPvwxJ0JzDx8s8PCTZ2mgpA798on1pWERT30WojdBnIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wJYvURVH; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJYvURVH"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-533202fe429so80781cf.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790626751; cv=none;
        d=google.com; s=arc-20260327;
        b=rqmVR1fgqXepBPv2CWvffcyAKj1H0rSZGtmcEkUF1lO9cq8VSQHMlg97uXdYIvO5j/
         vAEhT72HETeCurrj1aeUImMuy+b5Nf0scn/dkCOyz0ufqJgEEq5MzKA/zZpc22/HhSy2
         p/PVnLaiVEiyVJFGpaLP36cSuUKogY+MDrxfpm+FM3U9qin/S5TpF1mQIkvoajpKOvsu
         PWPyCA6385ec8cAF4OdAeHrWT2Q5987dhAYwWA2h1BS15cSiywPclNjJfr1hnoN7urv6
         iTNd8rncY8EEL66sQPBv24QuIYLmd+TRvLMTHKF53RETj0ZB5iWKutR9JYiAnEHxpJqB
         +nXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=46B2POKlbD/9ZIqgG3ctOki0bheokwhcbcExpv/6L94=;
        fh=743DxYmPA5Z0R0zb4xw+DyY3Tiqka73Brzpw+ZoZ3SE=;
        b=OeA3TupKEbiU7+BOs4fwQ4aoOs8fD9tBJXR3toaU60jxBaxhW0S7p+6ttbV4Od1ZeL
         +GsMCRZ2nEPIKu/XXfhUBIN0j1CLq0JAAKn3RE3dzZ8L4z71khhQq8/3w1YiY9eaIRPD
         buXXqNwA4LD7XCkE/cbRKmHLL6AKrd0w0vHU577dtqJVw37NhXfrO8Z4ROvfOYfbaocL
         G2t88FFDQHTYTT2isD9OQCbfeVtrXm7jXygjK1odXcT0W/FcuNVi6Eti/2BGKovMpPnL
         xFpRItDoDhMOf1N/mV3TKDIinNu8KsyRYPDtVHGsF0lxmHHSj3CobiwGcxpwZngpQ54M
         lh0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790626751; x=1791231551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=46B2POKlbD/9ZIqgG3ctOki0bheokwhcbcExpv/6L94=;
        b=wJYvURVH6euKpBEbQsBOrkzp6D/u8TO+sBADsbZp+khnI00p5R298S0T4YMZVB7TGX
         pABtTDcUcIft1470g+MNnFYtFPnnaZZuc7j2yYIoT0dj7zDYudfxVq85KMV/Fd5knkXr
         jzdCVR+pYEQWhhBKAiCPRcsKfQOCwKlEBlJLdqp/PJunK90/WF1k17fPp0pUChuZBSfL
         qOLK9ximHI30/sho/BtBbUaI3Rkj3Ks5f384JPlVPJIZpMJqWLlpHpCyfhhttzMeO8C8
         zPWMxF5CWUX3WPINhm5auX+WuEH1S77/nvbKeCVYRBB2wc/VHO31EIdJiV6VyAHnyZz+
         AKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790626751; x=1791231551;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=46B2POKlbD/9ZIqgG3ctOki0bheokwhcbcExpv/6L94=;
        b=aTuQ1wtW1O5CrX+DnAGflUDoBZUqj8JTJo9UPEM0reT1kUKVopPhdczvXLruSBY5+H
         Ip/QmeGd1k5Z1JPxJzUegBFUNwTG8PPlA3CloKOOUJBIMUKgXjmb3YJFEX9b1BrVNVFE
         cffXY51UxbAKpPhwdOaIJpCAUsmeVATN2V4/hqXUJAXtKfQaENYt69XT4uAiTqN2JgNR
         VuBVqxeoMNVvQjuA2p8LCCXUVcaka62HUl/1UdtxaHjEE8zAevsZ3vvsY+lLHubk8CYU
         At5dNo65Svm0WgmQoBa/uODnDCy78Bo5Bfo8sR/VonidEvM5ni9OKaKqL3+dBk5Aktks
         zZYw==
X-Forwarded-Encrypted: i=1; AKwUvByRTHhMkvaNEIQQuSiiaHX/N9GBwJO/Pq35ONxx8Bg9xAu5k/TPLkftpkR4poAE2BBiYIBWjwg=@vger.kernel.org
X-Gm-Message-State: AFuF++kv7Vx5wjGJRsOMNxGclnoUQpAPMvWt2cmS8sTAVDwlLPOAluLe
	CUSFgHGNXxCewGX4gyLHXZK42nf9CC/lGzsdetapZkSGDgnOzBSmWZL0Z90xu9zTXuTOSQjt6R6
	CMy79dYugpyJJrUEYw7WgPaBZauCerD5shr8AJ4DE
X-Gm-Gg: AYBFou39seaZZ9dsjCILtkrzrAnMcWNZt9d6vVE3FLafwVGlYeVLCY+n2c46eh5sGzt
	l0MdGewIvYznVWXx0VHMTsrTNZd+91YUi1kqM8OX35NpGGYdmBZ2dqO7c4one1+8JPZmDMFPkR/
	jq7iHJZTBXCx61GKlz/qdWrGDMSO5vxcQGV7R1qkHBItdAhTew88Kkpf+h1Faj4oG4vTGipR498
	GjVHeBGz74AsLpth0/KhLOozgBvBEKe7HIjzrSNG8vCziWS/vr42f4XB1B+dZqgwM1L+iQXoiYG
	+x4ya/C3ppsoqsSrKRupUlmf1j7aepMY+NHlj2bmpl8VFHEIxFHjyXxQJasuJf+R7SwVG4fSnNL
	khBC2NGpCy/vAY47m7yxl
X-Received: by 2002:a05:622a:c01:b0:532:ad75:e432 with SMTP id
 d75a77b69052e-5335882375bmr2014091cf.8.1790626750346; Mon, 28 Sep 2026
 13:19:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925135244.3715196-3-edumazet@google.com> <179062524319.3145.1235142898193592641@kernel.org>
 <CANn89iJkT9E7UdiPn25vCRKM_J9VZEkFGi_enYAteJAnsfiCxg@mail.gmail.com>
In-Reply-To: <CANn89iJkT9E7UdiPn25vCRKM_J9VZEkFGi_enYAteJAnsfiCxg@mail.gmail.com>
From: Wei Wang <weiwan@google.com>
Date: Mon, 28 Sep 2026 13:18:59 -0700
X-Gm-Features: AclHuK8SUJnO-2thu5URj5ytkd7uMaNiL029mc-3q4jQDJ3YGo-UVt0WEi0JfTU
Message-ID: <CAEA6p_BH76WVU9j1ee+bJ=EaSnN54ds=2vWJqi6YQ-J7EM27kQ@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/2] selftests/net: add SO_RESERVE_MEM test
To: Eric Dumazet <edumazet@google.com>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, caixinchen1@huawei.com, 
	netdev@vger.kernel.org, edumazet@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 1:03=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Sep 28, 2026 at 9:54=E2=80=AFPM <netdev-bot+sashiko@kernel.org> w=
rote:
> >
> > Thank you for your contribution! Sashiko AI review found 5 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 4
>
> This is a test. Lets remove it if we have to work days on it.
>
> I will not send a V3.

Reviewed-by: Wei Wang <weiwan@google.com>
