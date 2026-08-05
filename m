Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1AF46F485
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936894; cv=none; b=jeC7DWjdTRHeEYKsjCt0qMOUztCBStRgCD2ve9OB5/hUjLpG5vdxOf9djVuQ/wtooH0L3KnJ/SRm/fXVFTjzjAoo9YfAzk2UEQl15hw4l/R6liwon4c4wfljeKT/sK0yqSMyzOwdG2py0yRNZurgz3PZ2BcPzu+Kxhe5NYVYop4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936894; c=relaxed/simple;
	bh=YfkjAhdpp5OAkPMswdbROzDpgXP17HDOGzvEZlRthm0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Khgl3oD2zeDdx8H2P2dRLIwwPfIsiLc0P+Hqp+aDwq4sxDXDVpZACMctS9gijYzP2IYjyL7e26PkYJDfcucQQ8rgFomia1uzlaj7FVFmL4IvgU8dL7xpo1k3F5ou7/frlG3Ze7A7iaCE3t8m9TIp2sSen6Vau7qFzviP5yzagno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5bs4EnP; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5bs4EnP"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-664a09bc459so1451231d50.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785936892; x=1786541692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a2kJA7kp+bfsLvh6sqLaItq8gxDXwNn4FpBQP1pVCC4=;
        b=Z5bs4EnP26Q804nt8l8RTdh3m21TTFqB7AF2U1mtyDKNa1U8gBtnGS1Wymr9rLExlj
         GBLja94P1KMUHkeyBNttcH98/1d6saiOS3uevteP5J9+xwICaySXV5MsqpltCS70cUjX
         D0co69iuGBfWsIasRkFSfs0whdcOaIYkKvEIdHkDIh4ahjKo7dulkGDdPy1tyB7jcgi9
         oC80mDczkwfpvEz5gvttrMQplYMnlUtWy67Rv6csP4gxgfn23f2BfcKIoOf2F+wFhOaP
         rv5OF5TL6i2gyRgd4bsV0YabJ0ZR8jH5nVEL3UzxoB7fsW8RkBPkSoIWoMvvsBldBpa6
         aMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785936892; x=1786541692;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a2kJA7kp+bfsLvh6sqLaItq8gxDXwNn4FpBQP1pVCC4=;
        b=bYq5zEYBLCdRjz9arsSlQc8DQEUyQrmoDSEDouOiZ4kUQmr8DXxUbunt3h9TrjvhN4
         NZyHfc1fy9Wf1LQ+uvemm3jp12jGCYrfQHSUbjn/ZY31KSER2j01eXFspodqSqx8sKzP
         6MqdAP6R21rXzXYr6U64lkpyxv2jOa2SQuPfAvU2yWkHdMyYQOmF6uV3qJaCd0EVZGC2
         SrllYBsteWRbhlOLxgdqF46ai4p+meUbY+A+Z1ws/faed3ZJdeCCYK5DuwTPtG1tV/El
         IR/7IVcwa+0HQ+UchdgQzA54A6xsqLWD5xJxxzH4p13xPk4wyWeHXgwhlqsmYxsfpTZe
         JVLw==
X-Forwarded-Encrypted: i=1; AHgh+RpdBso1ociRrzNt2nPu2cz+e6DEOB21JYoxoYXo3zp69ce+tNj7nSg3JJnE0WRQYSCyfRS9PdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0s92mFWv7mQu/tBbSCpTrYjudYsJm6pvO5WwSbkT9z3TOrPje
	novtiaf7C3eTH+o4NAkeKFd7skFcmqJfHT0HaXC8o+3v6IgPYQDd2WOk
X-Gm-Gg: AR+sD12ff7iY0pMTGNW2QkA77QO81Zn16gyoGx/DUJf5MFaU69SrNlzKjLT6owmu0gd
	obXpGipUkpIwxXNmbmSnS1LWJqLDeqJYl/VHX2vqK0//VhF+Asmaq/iyPcSg0Nq2DJAK+QOeLu5
	/8+fXOlivlPTZ1Bf6PpcFRwT0C/evdHZExlhf6plQ3tYJbIf3vMrbCc7aHZGOyJgmnr4cQVL2o+
	GsiolZpZDFamc0RPINiFtKBnVtMaodn5w6TXipcczxLq/jnca1KvcReW6nEx6CMFH9EleJzjyLc
	yNm/cjm4JT45I5bQt5LG3Cfay4en3HLYGoV/idN9J2cHx8uC8/7CvOH2hoUAC+Uy0xPj5tEAJ4N
	wxtygQm6+W8FrxLjOWShgbfHSS0/glXtW3/tPPpd05stVJDOuL9+7MOaMODEKKPxLRCnQWc619+
	E2U90QjpZxaBwqtw2PTHnvXmvCaTUx0SIoP8Ls/FsUWuu4dyS2NvoAf3+tT/QjpN0fgsDwtuBFK
	eHEJp7hnkyUfT188TA5dXO2/BqfSVDonKXb
X-Received: by 2002:a05:690e:484b:b0:668:9c55:2956 with SMTP id 956f58d0204a3-6699a613f0amr3118580d50.0.1785936892375;
        Wed, 05 Aug 2026 06:34:52 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6699163afc4sm3010348d50.15.2026.08.05.06.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 06:34:51 -0700 (PDT)
Date: Wed, 05 Aug 2026 09:34:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Rongguang Wei <clementwei90@163.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 Rongguang Wei <weirongguang@kylinos.cn>, 
 andrew@daynix.com
Message-ID: <willemdebruijn.kernel.1dd05d081b77d@gmail.com>
In-Reply-To: <20260805072121.117472-1-clementwei90@163.com>
References: <20260805072121.117472-1-clementwei90@163.com>
Subject: Re: [PATCH net v1] tap: fix incorrect variable used for USO check in
 set_offload()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> The USO features in set_offload() incorrectly uses feature_mask
> instead of arg argument.
> 
> TUN_F_USO4 and TUN_F_USO6 belong to the TUN_F_* flag, while feature_mask
> belong to NETIF_F_* values (NETIF_F_HW_CSUM, NETIF_F_TSO, etc.) and
> will never contain any TUN_F_* bits.
> 
> Fixes: 399e0827642f ("driver/net/tun: Added features for USO.")
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>

Reviewed-by: Willem de Bruijn <willemb@google.com>
