Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7812630C16D
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788704676; cv=none; b=YJg1WiRVFCTNmFOkNddErkHmKqqihPFnla/TT4HfLjbb0wsm+giPjpDFlRhUhpxunFkP9mcCXe7zM4K6HfltwXAByjoeyracO30IiQ6fJgynJkJxVBnL9tL40Pjt3hsNgXllsJJddK22Bkdd9XQjVlS5x47KCbWe6s5Avw07Mz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788704676; c=relaxed/simple;
	bh=NYfI6PXdX7GkVce5zP5qG0d1rUqfqUKqfZMbwWlE8Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Prz7bGq104iJNqs8xub5hNCnex9UQPO72DWe5j3RfyxZmmIP0VBNUk4j/0SIZ06yBE5eKCKkhYMmfL0aIs78TiSRnmcGqR+7O24lg6Oqq0zjTUnomHqF5n4QRjUaBoKhAl6UeVmaocQT1qzcwnObwsegRHrDjuVl2ih6XN4m0sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=GeLOdA8a; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="GeLOdA8a"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1600d040e4so438196266b.1
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1788704673; x=1789309473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NYfI6PXdX7GkVce5zP5qG0d1rUqfqUKqfZMbwWlE8Ks=;
        b=GeLOdA8aWB6iYuy5WbVHGI0VfNQZUXtc6ij4XgXfNV4dMmApWY9SqFOa9qSH7VAp0u
         O0dqkZjhJ30JrBVMRPlYyKIB8FdB6ULiniZ54CC7GrmXeorDwkvbPj5FSBOfsMXZ/eqH
         +TddJvbckvtktSQpsqtrUA8MxerXU94mD/UE8oav+aCFc3DXEqQYEMA0jTnx0TtgXlSy
         lD1lI1J4EgGSlRnVcj6XZzQ/blHEGSYG+a+e4agCKJ0PzndV26m+p52XgpD/l/xUtu5+
         N7IVgCzUV4n1hxEmoaw70vGX5l/M2MSvrOLvij6Pqadf7O8zMVU9tkjwRpntxZ1xzL8U
         Y51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788704673; x=1789309473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NYfI6PXdX7GkVce5zP5qG0d1rUqfqUKqfZMbwWlE8Ks=;
        b=QEVMRdIEXBDqJgHTHB2UpYY5NbZ5aCMUXQk3jIq92WWxC3YY1f67SXKxPycoNm+Jut
         Zwy6DUb+j3GEa7BmKpNIhA/DcX2LBpx6aqqNCwxlCFxHvK1D3g6er72o92EnM/eDTMEi
         v2IA34MGTp3jVfJeveJoMoHNcQzdrqtBmWHAk38sbmYjtejGQpHLPCi6qRliVaTPS9aM
         hXlZNa6AUDu4qWbXnuxcQZ/XYsEdTnhb5j8RgDAkGy37/K6rq2n7hHL6coRJAm1DyVx8
         LS6hWdj9PMCPqCTaHLZwmzg8mGDnJj9tlD/dhiKhVCXTWg07ekvJEOhy7wcPJJwxHLN9
         xd5w==
X-Forwarded-Encrypted: i=1; AKwUvBwtrxYVn5P95/wZz+sKpKyMQ9QCDfQd4TQHNahjDFjKCXt11N+euiLLAZYImzH9G4Wtqm2Bxuw=@vger.kernel.org
X-Gm-Message-State: AFuF++n6Zmd8mp0sLTIYmOXlpfubPBG31NmRI+Mwi/2i4qP8mUU9P0mV
	AnRErGJzF2gPMoeoTyegK1GRcAI5H9E572z8fBYrhtNBMo1qCsBnqsDrolR8QywbbA==
X-Gm-Gg: AYBFou1ZKo7iga9dhbIRpYb0BTlHtacoS2gBMN8ejCcd7rzk9SNdTI4RbUqErphba3k
	+pYi2nRVHWFtS/TeexPE/GatWzRRUNrW6rGO2XeXkpvKhjxW4r3Mg78tfocQOFVxFtQjNBBOPvH
	IIzVgRWUzocZUmQUYzN/6xiGRsCkrcFoJr5/1PROF+BJ23UJJHFwvgZXp5F5stHqLvHGeD8EkXx
	xIXcBhC482FEwS5KhLLxmyFFezCCxhlI2LSwkKPbBxvMLV8/ilfJej5tRdnxg/0JTc/TDsYfW9x
	CmgHb+IZv0j4CTfyGiKX/+W8jl1h4YBGM2fmH6FeuF3Z3BdV/0EVGNgOxS5cTvx368ubgFe0ZbL
	Qkxxbr2o7Mk9o0vWyQohyyfrwIf5+wg8cssmWp9MgVVqw4YUPTCOE5xQqp+oikp979irn8BYznU
	t6NG82icqmd5Hub4hPziDTTNU60O68pmQOGlQBrpYOJYUV5KGCUo8tpg+kIbAhtFDCf6IJr8xe+
	a8NX2Why0ucxw/82YI/xRQ5bIsHh5hAWzfpozb4RzS0+uhSpDOEDrprN5uCggWHjh2HJr9ig8Th
	pxh/h/+hircXNHHycNSS1pDN80gAV0QNZ0Ele30WZ++7AOdEfoLdOdecwI5wufnBhFmenwyuVAx
	l4Z6RPKnAbosPVkZmYHZ8lzja6ZeeHxMmeLqw8qR8yKCQuwQc0CwnPT0IZHNPQ3omfTIBorc=
X-Received: by 2002:a17:907:9703:b0:c25:f7dc:2d0 with SMTP id a640c23a62f3a-c25f7dc0961mr812611566b.17.1788704673604;
        Sun, 06 Sep 2026 07:24:33 -0700 (PDT)
Received: from Desktop.fritz.box ([207.22.59.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6bee8e8sm3605988a12.23.2026.09.06.07.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 07:24:32 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: flowtable: advertise the vlan match in used_keys
Date: Sun,  6 Sep 2026 16:24:31 +0200
Message-ID: <20260906142431.482005-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906142018.480577-1-julius@bairaktaris.de>
References: <20260906142018.480577-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sent twice by mistake; both copies are identical, please ignore this one.
