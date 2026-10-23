Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764115;
	b=A1f39hnUpF8s0POJfpUImHir+OoJ3RVcVbQxL0HHAEVznmfGPn7ee32o6v2H5ppHC/cs
	 lsIJbhE765sLiDzOCdjviRtFukQXjMwRqhIux8QM84X/plXxdOh0kIeJU2ymQNT8UXTIY
	 TY36PFPsgARGq0G103eUWznGi656p+YkjEpGK7zK6+4OTftRhel3MqvYCjliVBvTKe0bh
	 1GdYliAgq5nP5NlGPSY77DOB1/IzR6W3dbTNd9T4VAcNJyg9Zq8ABlZIwntaI237O2P+d
	 3AX827sKVkx/U38wci+bj/gb2EKiQgfAuf+BhpL1GMwZnTKPkr9gsZsvhO2J/g+vvaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764115;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding;
	bh=lZbs7+S2JWQgMnJqiWOBZ+GTjrO4vTsXuw3OJlBG4ro=;
	b=3cR8P9XErLNTTiOlhfvL8qFjQl8jT3n5DuTD15JgHIykvlMQgtGKOmf7IU7ggTnKyOwi
	 3Bh5MBHLNyZX7K5yzZaIGGdJLlTCt8k8n+4qHsAgxBVBo3vK00E41sbW8UiabYMuayMYA
	 3kbpKaenPWIjn7rrPnkWw6ywX9xX/I6ztWf/NsqyCrjfe+4VbXRbjY7DEUjCawXLcdQH8
	 Djbpqf0EYAnSVPtrZRZ/fKuGxCUuB/2Zx3NFjJYubNj121xTbnCZ0W20R5DWsldM3SLMh
	 6hSdJ0Wf9CUFaArtOizKSG/o1DMT7UW6BgRYnmKq7C06pHJTCqqyWKgPqRWL7BazRdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h2LmkOgl;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U7HxVhMI;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA48606A323
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 14:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DA48606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h2LmkOgl;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=U7HxVhMI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792764114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lZbs7+S2JWQgMnJqiWOBZ+GTjrO4vTsXuw3OJlBG4ro=;
	b=h2LmkOglm2Efsz50Aq8O4vTnVxa43KJepaGQlCEbl0abWoCl1J0XwqI7U2kJwGEB341I93
	q+38GmK/qw4Xgmd+6VVqcqtrFT8weOksUWsE7R33xMAgjb+E4lcb2aEFELh5/TYNNppOwZ
	CfCBdgVLqxBjua0Dh2Osck+iItwvsdc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-VqiPNcRyM1mhQWL002JTCA-1; Fri, 23 Oct 2026 10:01:52 -0400
X-MC-Unique: VqiPNcRyM1mhQWL002JTCA-1
X-Mimecast-MFC-AGG-ID: VqiPNcRyM1mhQWL002JTCA_1792764111
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso5566825e9.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792764111; x=1793368911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lZbs7+S2JWQgMnJqiWOBZ+GTjrO4vTsXuw3OJlBG4ro=;
        b=U7HxVhMIJUwl/gN4EyN3qPQAmOr1l1PHF+uAQyepvimW0xlTUhFsMswwNVzFGx2h73
         P+hb3h7e4nNlT8+QZdkHZG4MXMXFkhafvjdEw9BXhmFHQ/ZRd7OZXHvSiN4uEKphNhbz
         HZ/gT+KcnrgVttvzUpGf9GmV6GRYOaY2NU7S16dEM0w8vfj+mklZmdILCtt+hvWBqfpe
         XnPi05RHjR3MREWzL/5LvDSU8iqYr0i26PHZsVbw2dGJQqP6wRA/9imK9FmZwu1jpo9O
         GzobYxDot5rXuTZyR/Lo4Gm4il9/GxILi1Qspoe23ZY5mPeTatFigs6vMjxBBA4DycEh
         yS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764111; x=1793368911;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lZbs7+S2JWQgMnJqiWOBZ+GTjrO4vTsXuw3OJlBG4ro=;
        b=L5lQSsxJbGAUrc1CMTt+3qf99Z2OZywIY6hGGUpqbfQxod7VvdgxnoplC0Ffmzg+WD
         iOyud5fEEtm3z3j/AjxxheYJHmoBCWG/nuR3T11FnGN+7ot9sPjJFiPY9mFubNV6noep
         DsvEO2JjOBH6/3dzEDT+WBT3FoJRcf1/rFjF6QwFaT6VHexkI6uL6pAPP5LIcmXPcMBF
         lbKRiqsLU2mF5YnUfFWo8roWRI1HYR1yF/yBnXyWa4liNCPLQPL9lfbV4k6O1PJ4lb1X
         lFRBMdnsheFYHqjOgStHdYL618aK7v13Fe50bUYcaM7Zgjl0mAsYGK3Xoppj8IOHcR7e
         quVg==
X-Gm-Message-State: AFq9FYL9H02grMvumfNKMxdcZuz+okuJasl2UfO3XLjLGE7G4fGyFvQr
	SKNntG1odUy0gSSOjYEJS0m0WUCMxwRnfXVNel9IZPSuJ55pHTfST2p4Jjy8nu0EzS8BSumB51S
	wwx9rWV3h+z+OGKfy2/O7cHLS1T/qrRsDCsoEiEfh8nRF5P9rYvUyQFBGCA==
X-Gm-Gg: AYBFou02fZNjA5A97IW3O1yLet0UQd69A7B4HDmNXZ/dir28KxtbhMixGbVDLW1bJDw
	tWMNc4Mx7ofLGKml6SjRoTzU+rUcDKPLnM9K1AvezQDR4HmiMtqbqh01FM0IddPXqGymlzUHflh
	yaGE7I1J3czndzIA2ORRSJyeue0lfjA1vGi1umJJqHxBwJ+XkFHK1+/UwFpfhbw7pSI2lifua+f
	D83NZyEBuaosug5CmHFENRmuZMGqNyTpqSRmHccsV16Gt7hOWZOPFZMOxNngZeDhY3rgJMG4Bk1
	rI0DA0fcB5G6wNNgigfZVGJdOOw84d94wyNDoU/pithUC1O555uqdMxQQk4YSNQffRNyIQn0QLI
	nTi6+kfH8yFc81fyB8FG9A3BM9FJR3oLZ5KIGty9nck1qxsmDDRwUGrRMhjDO7EoGMDqrb+771A
	==
X-Received: by 2002:a05:600c:1385:b0:4a1:ce33:1536 with SMTP id 5b1f17b1804b1-4a211cd08c3mr41353155e9.9.1792764111262;
        Fri, 23 Oct 2026 07:01:51 -0700 (PDT)
X-Received: by 2002:a05:600c:1385:b0:4a1:ce33:1536 with SMTP id 5b1f17b1804b1-4a211cd08c3mr41352615e9.9.1792764110821;
        Fri, 23 Oct 2026 07:01:50 -0700 (PDT)
Received: from [192.168.188.234] (ip174-129-192-82.pool-bba.aruba.it. [82.192.129.174])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d3f9f28sm18240f8f.21.2026.10.23.07.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 07:01:49 -0700 (PDT)
Message-ID: <06502f83-f22a-4522-9a30-60b2478a8c2c@redhat.com>
Date: Fri, 23 Oct 2026 16:01:48 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Cc: network dev <netdev@vger.kernel.org>, Matthieu Baerts
 <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
Subject: nipa H/W testing suddenly failing on CX7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Mat noted that H/W self-tests suddenly started failing on the
mentioned NIC:

https://netdev.bots.linux.dev/flakes.html?min-flip=0&br-cnt=20&br-pfx=net-next-hw&ld-remote=netdev-CX7

Judging from the test output, GRO stopped aggregating and the
driver exposes a single queue?!?

I could not spot anything obviously wrong in the relevant
batch:

https://netdev.bots.linux.dev/branch_deltas/net-next-hw-2026-10-22--00-00.html

Could you please have a look?

Thanks,

Paolo

