Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792796322;
	b=lNjOj1E0cOo85/ItM86Dpqg6cN9Me8Rq8Mg2zvvrWL56OTCspBNEbo2Hw/zLr0kyjohX
	 lVIKHdkZV+v9MSDMC+9PQEAMrvSTTBoEQe0exTae3bGm4iBwQp38WGCaFuL+RDbcyB6D9
	 T2wOfN5jZFcAnzlfwCp51mtfCxkPqhv0uNe3NectneIUJ1Nfajm8CZxyXC6MAu9NNwAJz
	 A1IAIObUVa/OqZD2VlKjf9AE5p0A2LkBJ2wdxMU3krUqlj4VkkVP9ykZmmHZkSwYR6mXV
	 fozaKIqF2vA/tPJ1S91QUmE4e6oM+wce3W18Sbws9E/iCF4CSvP5bq8HSC/VpNsrjQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792796322;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:DKIM-Signature:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=GXq36bGT56R0FtfZYg21vEMJLEvNtTHRRADz5kWWrLQ=;
	b=bFaD0FS4QfwI/UF7dPeG0Vf4P0yY5PLkS40w9l0ho78U4Eug/ZyqY+7A7PkcJekPr+Th
	 zLvysKGXH+NVzdqGE/ka+iDOQ8rbK9BwaZX6NDph7DcfRCPMsiwdum99ezq8uym71NoUu
	 V2kr/Fq/pQ7v1QyAO4i4EVmCVAkQzfHMqRkOAVn/4V6Tcd0+kWOwl2GrjXuujh8UsVmNs
	 4qsc2xi5iXLevrmepEDdaIIMoyeBIUlpLBJTp5vNU5MqqIjmvSnMC9wwzHiRD+s+44i/p
	 dQ3Dn5KDiw+b8bgNA9QwrgHhTmvUtR9w73Q2GAbmintdY8zkduyvs50jgORDY7VS8vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zx2c4.com;
	spf=pass smtp.mailfrom=zx2c4.com;
	dkim=pass header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=lfi+GLS+;
	arc=none smtp.remote-ip=209.85.219.102
Received: from mail-qv1-f102.google.com (mail-qv1-f102.google.com [209.85.219.102])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D83A606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 22:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D83A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zx2c4.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=lfi+GLS+
Received: by mail-qv1-f102.google.com with SMTP id 6a1803df08f44-91986c5cb75so13815736d6.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792796320; x=1793401120;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GXq36bGT56R0FtfZYg21vEMJLEvNtTHRRADz5kWWrLQ=;
        b=kLoT56f9zuD+QIoKJBYfRn/qYywyQkTlJoCMQIInDJa0OT7TazVmK5ttrUZDrk53+2
         J6Y07r78psbib/f7paZPZc+TWLcssANIKMLYOQjoP6N0pG9W0IyZZNCC+y1ntl6q5QLe
         R8iY95/0AI03Bo14sbGkPf+cx3VvbbDMw+gRIRocq47pJzDr42VupgGYupFxmqWmJHA4
         gFnB8psI3st69Ca88cjyNPCpW94IZ8TAd7c854MXLdLNX+1dpbNtcwNfIjnQjBimrlL6
         2X4JPoW1M+l6FopDLhZLI5RbEUWrkqBCaxmK2N849cRgfFo+Dv8r158VUODIj0RWylCc
         dylw==
X-Gm-Message-State: AFq9FYI1BhpPRJ1hAKWgmmnn9Tm4iimRNN7yFcbxZ/kb9upMjOquKnvt
	EMhmvMnf+eFwle1Mcfdp9GJAB7Hy1jqTdgvc4E2IEMcBvRChSc0g0kUmpfzP1DkYzf1WtbM4dej
	ew2bzWhByt5Gjk/e7GAGihxA4u24bwBORBladp5g=
X-Gm-Gg: AYBFou2+Mleu/mvRJhoOgO7CqP8r/vetvD9BVfh8fWBz+Qn5A114zyNzSsORZtFmcPh
	aTVAOUpDGT2RQQaD1EyAZ64GQVvGaNRKsmGovGqVYlgz+kfX+n91XQoeeXD2kDgMb7VGBaOV+QI
	AEgpPvKzHFWTlKC+pjfHIlXdHJEnYfEypwxs/xRuuIUNtpaSXrWPHH5NgZRNXIAeA1zmPyfHnOY
	hlLHl4wiFZkAuxirOvBGR3tjMP6o9LbQiPNOyKAS/URDBARuxlkqEsN2RtzK0ly4bUOF7pJe7h3
	Phs7kphMkB1ePqMaHOl5gNnpdrfqCYCRGdyP0bT5Q4fLeMXqNo9wtJwvNNMIdKQinqmCz0XGvOf
	QTA==
X-Received: by 2002:a05:620a:2b83:b0:93e:fcc0:6946 with SMTP id af79cd13be357-940ef9956e6mr69346985a.57.1792796320157;
        Fri, 23 Oct 2026 15:58:40 -0700 (PDT)
Received: from zx2c4.com (mail.zx2c4.com. [104.131.123.232])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-940f0677243sm5398185a.9.2026.10.23.15.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 15:58:40 -0700 (PDT)
X-Relaying-Domain: zx2c4.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1792796316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GXq36bGT56R0FtfZYg21vEMJLEvNtTHRRADz5kWWrLQ=;
	b=lfi+GLS+HJ7/ndNJuguo5ZIBDDw5UULREIbw+CJrFiz64K/0fU1/TFJ/34Q75IwuEouyp9
	FKppIkrJNnU1TN87aIbUGj4NeftOebukNVtCAEC4jppoe40x0wxvbbKSBDbsGndtwDIbCt
	yjmQDbdtkQbaoUhANyoG9+7ZLGSAmFU=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 01d9b725 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 22:58:35 +0000 (UTC)
Date: Sat, 24 Oct 2026 00:58:26 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: pasichdev <apasichnik9@gmail.com>
Cc: netdev@vger.kernel.org, wireguard@lists.zx2c4.com,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] wireguard: peer: free packets left on the per-peer
 queues on removal
Message-ID: <atvmkkF3UQMhvv3U@zx2c4.com>
References: <20261003201625.4572-1-apasichnik9@gmail.com>
 <20261023211626.99784-1-apasichnik9@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261023211626.99784-1-apasichnik9@gmail.com>

On Sat, Oct 24, 2026 at 12:16:26AM +0300, pasichdev wrote:
> From: Andrii Pasichnyk <apasichnik9@gmail.com>
> 
> Hi Jason,
> 
> Gentle ping on this one. Patchwork shows it as awaiting upstream, so I
> assume it should go through your tree. It still applies to net and
> net-next unchanged; if you would rather have it taken through net
> directly, or want anything changed, please let me know.

Thanks for the poke. I got bogged down with some other wireguard patches
and this slipped past. I'll take a look in the coming week.

Jason
