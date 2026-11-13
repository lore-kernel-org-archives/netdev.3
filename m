Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530282;
	b=vcybvBgKVgcTqeUSgaOP6+3TX5EXk+fGvE8vYzxgYgCUmkNKmvusCWypz/bnELQe9EYn
	 Fh8AdqtM/V3k5uNl1r6Lpj6oVX5T8w2MnfFIaAwM8otNdcxP/5ipFH1GrHdFGCpFDKl2G
	 8RZ9Jn3gzb2UGFxefR8rQJSwWlkc8RxyaWUYNDV40QPhmy0wLjLXEq42pb4vzDKNokIIh
	 YUzlZbfNjsIGsZdaT9J/R0kd1GKHCHz3chSHMt3MfMtrUULnZ4zAiltXcmsLP/ZBqHr/P
	 su+S9QGljQyB4h6T1TtzWJGns3e2VVOVLa3HPANOyYAB+2h4AFTvywam5QE+zSswwHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NJV6PkKyLn8LLaFMN3pT/YFquqSkktNVkI76CPkMC6c=;
	b=mzfi7bd2tB7uQRWIs9cb6wwT++1DPF0l7FTpwuZor3jbreVl+MC0o4DwnGuM1xUG9k74
	 sOQ3NjcqBLY35QnD6Kk0rZD1Xtcx7wehnbSgw8pz1J6ulfWbt7ZJwgsc7RVeIQFRv6Ipc
	 QEN91EA2qHSwsvl+U45eJUozlEPmot8WPLoZd+M2me4J6Q0oLvS9U4cVB+AaGum2+jD3n
	 PNjvwfNl5cV2ZW/YNRpVrZN1Y+rlgKBdiloQaGdp5UUrkNi6EaIlvXq82D81f/sJRiCpY
	 UsKVMXNDC6dKoApAvTGBmOmbwRiTJNLXueH9K0NhYw+su3obQW57yhxWLLxkcLH8LxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=POFAfAMl;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB45E606A327
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB45E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=POFAfAMl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a215e64962so5888965e9.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794530280; x=1795135080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NJV6PkKyLn8LLaFMN3pT/YFquqSkktNVkI76CPkMC6c=;
        b=POFAfAMlzOe7mxCGaHxHhIQ7MfNoy4mBZBhwXuST4doYXLkrQmGxyoCIufW4Jk67At
         j+SxLUvrhx6EUXK/D9k0evL1gDF8hiWJLQDrmNfM//XrKTWnTJw/vTOLpO3tgrQg19Yj
         LksjfoErsWEKyChkkC5F/qzJ5ZY5Q1G2xf+FrkrL6v3FrEmBwXhI410bfV10v2FI8Inn
         4wjxf1yXt4ucgi9yzWO07vVaURDrquFhvbT3oml32JN1HHN6VH+mVhjIm1SYm0l2hQba
         EvMN8LiCQhLVUPc/xMwS7koslFgMA7GPJ7ZoV6Xt5b4wMil3jIWoqcpNFgCOQxNV6i0b
         2ZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794530280; x=1795135080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NJV6PkKyLn8LLaFMN3pT/YFquqSkktNVkI76CPkMC6c=;
        b=NyJaLJUdHu8zVR/ZidZtenuNkc8EaaodFowsw2iATnX0ZvjPdl35JqoCuk0Xf5sWFU
         KuKmuWGWFEFYE8Puy2qq4SiXm2rNLSdCjgtYyVhFdiDyudJYVYPhFrENWBoBzXek75ZV
         YvQzpj6Rmn/6MXtpMFVPUQALfbAB082KfsSgVP8FUZWkJDuExAIeWgZVtYkb6/vuNCwT
         Z7BCei956qblYxIpxiUin7zAAWh+fS+j6/H5s85KZcKNL9j4Kt674WQRFPHuba7Znmcd
         9jeEh/84jLhBJW6+60sMng9+flPkSC0q/MbC5VUlxtjM6IXw/F61N3x+TRUpoOEZXSV3
         VH2A==
X-Forwarded-Encrypted: i=1; AL+hErGRNA34cU+eeeMx5W5K+sC5PhBPiQM8J/juoj2fUUp4G9cFsDVv89bw7gMU9Eud9J5JuNPgDlg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+06tdct+QYB5gbhpxwC5/1ld9ERtXzkCMPBWCCKTAUlOc0m8bg
	gCbOxFMMwQGdjjgoH3tcrjHgdrbx1iAm1rMgFwl13r87bHGZMt2Y2s6m
X-Gm-Gg: AYBFou3v+noPxCc1IZtwQlH5ymewxBkS2kBfFg5H30Ys/hok26rdbd+/3QghIjQhH2+
	5+VFUJNSXXDJvfzlfpxVVzZH/R1iCJsHxSOTegwBynezijkv1+5QoniMEnTjoowxgj2WeC56sY9
	ftzhpe5wIzGXODLPZKHHLrPQcj3mWgWJmFwNo/Rty7l11Z4VeJpdM57hYOhwryScuty+IXo/gPz
	qBFnFZUTu0BSN8ArMmY9bAlHdQx/239vP+peUw7ZktMAyIMh6OtiAEfnZ1cL3dhtZoNhUtdhUjW
	nvEmvW92a7vIMpVycOhydFQmNwPteJhYEW5TC5zzWafAzerJ9U9rfTGr00Q12R5zIHcLZqbIOVS
	TKIMG2+GrnVV2k2+FP6buum1McY+DdFRNJGEcN3ZdfmN9AzNT4je7jd8eOhygb9jlfl4DE4ZPeV
	zV1SJdiBJSAPx/K2ZuJCw+BCMl4H0xeLkNWfAcM8hJErZ/pmMX5246THU/7YReCpdINEGEF3M/+
	nrrp+i1T4Gecoabr27uJJKEGJkVGtYX8/iOvG4jdf25TDEFivbMaCvFTdO775sTqELSfbkHinQ0
	sh1aVfwDBRKc/5oqwyDk/co8ztXpzxNdS+82AmAL7jSbP4ZFqT704CXmuBnZ9Q7oJN817zKgSn3
	2aWn8+RCMWz4YxGVo81sP3y2zcLNJFmWBC23gllJiT3yDLQ7kI4X40mCjrdMPh/lja2+uKVH3cE
	MAFmmuggK/Xk5LeWGZ
X-Received: by 2002:a05:600c:e558:10b0:4a7:669c:c988 with SMTP id 5b1f17b1804b1-4bb55a96404mr12042895e9.23.1794530280470;
        Thu, 12 Nov 2026 16:38:00 -0800 (PST)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c8d286480sm1868483f8f.7.2026.11.12.16.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:37:59 -0800 (PST)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	arnd@arndb.de,
	stefandoesinger@gmail.com,
	krzk@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/24] dt-bindings: net: Add ZTE ZX279128S Ethernet switch
Date: Fri, 13 Nov 2026 00:37:57 +0000
Message-ID: <20261113003757.3669262-1-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027214830.GA1267186-robh@kernel.org>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com> <20261014072109.1759502-18-ghahramani.navid@gmail.com> <20261027214830.GA1267186-robh@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rob,

Rob Herring wrote:
> Use the ethernet-switch.yaml schema here.

> ethernet-port is preferred for new bindings.

Thanks, I will do both in the switch binding for the netdev series.

Best regards,
Navid
