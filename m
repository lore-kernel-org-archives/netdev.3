Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6844228B7EA
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602579; cv=none; b=aKBoKHyhndFUQeEfS/R/sdmJUx6ilJrFNQbELZkG1X7nTRTHpG8WExVFBVv+DZZs+1RWHw83/vqQQfIe+2y7DpKsLaoogCvfMa7uaq7ggc1hGNEbs+w8lI3ODXut2CqeYngQRrSWGcc2ZeJb7JdmoRCXZogKuorhC40aL+xW0dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602579; c=relaxed/simple;
	bh=6aP65QUvY5/9HxJa0LScjRX4MvvMQe7UzEf3+atJASQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1MibOt2ozNYUobl6dfh0DOA+wmCLcs3MGm248AoLWQ9uANBuLBEA7mE1+ai5IrhNvzjEkoVt3MiXtLlD6GukQJAVyvVYsUeLLuyJ82PijlTe8qn9HesAbS3U3nCyjbb7KcF4BOTfztdJU4lIDulYTLrDxOZPLd4RYXjS0mOF3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbLhDuew; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbLhDuew"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cace91f112so46073995ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 13:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787602578; x=1788207378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6aP65QUvY5/9HxJa0LScjRX4MvvMQe7UzEf3+atJASQ=;
        b=cbLhDuew1AZAf8W8TGzBw4Nrq92BTWEz1NYYaQQlXpCprPCSISPcweheNAJ1Z+oP60
         49qfdWZDhhtlCTbGuEqz9Onhltw30QJW4cHgo41cRosA9op6qi6v8GLHFOJdg5wEJFCf
         P7DlWQRX/N58e5neGnY4yLfQnUhdgiWMzprMkd/96ZEMb4B9zd9fqy7HkeDPl4PJkfxl
         qHymsEN4X7+v0SkDpt10tNp+DeHmYzoSRuXZJ17vi2pstVP2CPrOUISucdZl15YO6H9W
         PO3fP5UVDymwWkzq/S8AgjUKyxhUn/NKRUW7bz4V31I5SNaDyILSce+ctY4r+xC8FUf9
         ZKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602578; x=1788207378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6aP65QUvY5/9HxJa0LScjRX4MvvMQe7UzEf3+atJASQ=;
        b=IfrrgDGQcKgJxsKE3PaU/F9SWNtJ77Sy02J7fbJB+N+l4ElkGh5f1RHVNEA1qljv9Q
         +WrJArvk7rDFy6RMEbiLXG9TmRNrIZC1IJolcHX/GDhBqKRk2tNonmE2cEoxxDge9lP4
         BJFlzKvHtYfS8fR93RnZmS2muGWFbk+FI7WzrVNOxoUPi2XlLjRkafJYGIEZG1xwcY5a
         1zcRlm4LoSVsXhJ6dn8fShXHKbkEpWp7KA+WC9oT1yrER3QfzDSG0u9W7/mpWLBxmGCF
         /tBgxuWUG71RUCN9KvkAvqVYuTGt32yOqtZ1uh5TvTg8fs155ixerTgrz6RB+agz3Ekc
         4IzQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqpn/ESh2YgpF9sG9lf3q+08kc7YNhXGPOYFEchNprfPnF+8xjgpkv6CnnbH6Brxrkn88lJ6CQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lrsG1jZObzjQaa9uBpNsZvkXM6ts60V2Iv9Jw5tX2UPD2vDDWC
	iUXddCd1Up/1b6XGvfaj/TuodVwLHTWGZv6hPsSRBEzNClrzQKoAm2vs
X-Gm-Gg: AR+sD11+htaJEjcEMryXe7owgSFU5H9oo29X8Ffxgp9CooU01h3QDT68KG1hyScCeFr
	ehswYEFpsyL91s8Zf3gbb7aLPfQCAMQxTrGWk7vcuUGj6wastmaRB+28Bn4TfR7xfDucW+E234R
	NxpsS8sRuasypjV3NcIDHTknCr2n86GA1fJUGOd1dIwv4yDahcekUECpBcSEHZMiVa6owbXpZaR
	sXgDSjc78UjItdK7wbWXk0WMHw7rhA+vqSXrkvoOsfI0U+TeE2TX9IsT476/wd5bNDRQL45cNNV
	4VTNSaGBY+OxRXCQHlrodAoYs+Z/JrfOdg2tDyp2voWuUD0iDt2OBx5B2z6QKIzOCsQ5yPaGwQE
	fPXbsFbLxNqgTJ2xo0tH6/6DBwaoMSTm3zYCQvl3iBeh0Hz6+RoeyF3t8tzJdHXTNca3c8v1gXd
	PErZpIN1emZ8pVa4GfBmERrowQXEeFXp4ygRJ98y1+khhlWDkrRNydk9IlxeZJtNWzk6DBGH42M
	ITVmxpSonVCWiRncBRmVtdt
X-Received: by 2002:a17:902:f70b:b0:2d6:3c2f:6a4 with SMTP id d9443c01a7336-2d670d07a21mr401857975ad.13.1787602577667;
        Mon, 24 Aug 2026 13:16:17 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:a800:1010:84e9:817f:7171:6561])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676761c1fsm20728075ad.16.2026.08.24.13.16.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 13:16:17 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: idosch@nvidia.com
Cc: AutonomousCodeSecurity@microsoft.com,
	blbllhy@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@google.com,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tgopinath@linux.microsoft.com,
	xmei5@asu.edu
Subject: Re: [PATCH net] ipv6: avoid divide by zero in rt6_multipath_rebalance
Date: Mon, 24 Aug 2026 16:16:08 -0400
Message-ID: <20260824201609.27226-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819151504.GA1248049@shredder>
References: <20260819151504.GA1248049@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for reviewing Sashiko's feedback and for the reminder.
I'll review and respond to Sashiko feedback in future submissions.

Thanks,
Cen
