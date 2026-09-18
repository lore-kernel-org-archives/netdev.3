Received: from mail-oa2-f20.google.com (mail-oa2-f20.google.com [74.125.231.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316C94322E6
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750853; cv=none; b=ZxoLp8rLC6vx8VHwd3UOwa2tI5i1TURr7HL8a40QHHgI0uAn0ZjdLroSX0vchue/d8qdVQOaskHRZu+FCtEaD7mDKapTqNHRt9ZXZhFeH6XrsAm6zDlRg/GAbFJh66OsoVrLqxr94vSZd8PYmZhNip+c4x6wztnxBcbbaDWOly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750853; c=relaxed/simple;
	bh=gcX87xrdiRq/JpJfHXf8dc2D+Zg5tedVXGlS1DW/jBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9Lx1WWmDPbjZqh509FhylpjBsLntTQ+T47D+4Yk6NF59qDTGMJgGuK1RR6atC11Oy3RbE2cJy3adsQU+sT2d+lI57lx4vh+d1kuCNrgQZhEUGdQz0Zw3OzJDzwgbsGUX+yPtwVS9NkaCTLlM5HKqXTOtYTHGDeAWmnzk+oF8UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpjbLjak; arc=none smtp.client-ip=74.125.231.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpjbLjak"
Received: by mail-oa2-f20.google.com with SMTP id 586e51a60fabf-4788fe5736eso661100fac.2
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 10:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789750850; x=1790355650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gcX87xrdiRq/JpJfHXf8dc2D+Zg5tedVXGlS1DW/jBw=;
        b=VpjbLjakR65SG+Uj0M6mVLb5KJvo3lYjQUsygd5JZHh85k3t2gof/14XDPeu+5jApt
         ocHKF0sNyC+gUH6ChFZhyWG21dNHnNW+oJFQ5Y7RnruwlNxBWILG8diRROfG/IAUIfR6
         ZMUpLR89dhNt/vohNehTKmHzBk56jv9Pq7nvjkBgWSsEa/MaQsbEwPprYs5HGBnI36pu
         MRoM66Hyy0S2Cw1qdd1ohBcDjcvOaixgZFj2/W8yUghQg7VCU70muJ2TV14ZzT5gsCeH
         iqxyrdUIfVjs+Ppo8E6A1hl/V82Exs5n94OgGp76Iy6NqvMXBabJUn2bxn+toiDfhWz3
         inGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789750850; x=1790355650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gcX87xrdiRq/JpJfHXf8dc2D+Zg5tedVXGlS1DW/jBw=;
        b=fgX4g/FTMd9NbkYl0R3fWwbpIvL52rPWIiMlrOhjpyG/2qindrjvtSMqokBxWAeIKh
         e4oQVfMFXFewithEg/B+R8rHdDr7WJwIBbl19IbUOFuFdEGPKqcLR1GsHZNYaLmS1Ej0
         Nc928yxik8vEhiCcAAXVFCusEiqPDk4TbaoQdYOO+BL7lAdw1dH4H+bMxr7L6Qg7AjsP
         vU2FvdorXCZa2hw+QuG+OCIus/OKrRBQPkr7nlzoK1Msql2FL5I9cpOiHDEk4UVIjbal
         D/Ww24HgelflVzgNmaYEoKZtGLeHRJUesOecypbBnUu0Of9fxtZp7HrUqdpE4/UJNz0Y
         0gIw==
X-Forwarded-Encrypted: i=1; AKwUvBw4o4IrYkXpl2rMvpM1dzX5HCBQ+Voewy37zYN48kImMP5mbGO93t3xYPbsQGsBIrUxDB+8VPQ=@vger.kernel.org
X-Gm-Message-State: AFuF++muPUbyMinuasz4kn5KSjxlYmw3F0S+g7SVYNPP3ETacAhsAoL/
	m3mxKeimR/F1liKZn0dskk0vdYT7ORcCG51FcOsJs3M5YuasPX87Eu1k
X-Gm-Gg: AYBFou0O28SVnMGTB6tDB9ef8xKfGwZkfM4V7JgvfdJFpIELXoH8jhILItDiW7yTACn
	eyweNc5hRmvfat/0gziMcS6Mp4mniws/P2eitgvdQNSRp4mgFk11PDvZITcjVnS6CLaQPMGGRLI
	bYvbx8KKnMWUg37rd61HIyfZZNUvhe+MxY2eeoObbH2m49YXn9l0SE5cnkrCcH+SSafdBCs9VbQ
	eZ92vtNmnQzjfko5VRGId9OjQHYozRzQO9G5W8J26ESAzmY3DuhIGS3gpeg4CDFU38e1J3gTT4B
	L9fDR31aMAuaKFR1ASONumWorMWfeDzxN0T7Dwmfy8hUvNKnLA7dPK900A2Ao8gPNhfpL9b9jqn
	nY6M8+yzcYUOy/pmsQPTETRo3eNbz91BUfXAUCizimqz790KwNk1BpDH93xI/BPa0reyDYdJ2Ee
	XU8amJvK+l0jhhSwcRiyuGMt1t7zTm6gUC8NfdXRgKcyysBnBU+BqMit1Ldgj9d7kzoyXvv22l5
	3o1xuoSRSAro/b8OP4Y8+Ki/fngypo9AWlNZ1maFMknSB66Wy+meDDN97tKH5PF0/6XrOFROuwY
X-Received: by 2002:a05:6871:4709:b0:459:2c03:6302 with SMTP id 586e51a60fabf-486e4f2976emr3735381fac.11.1789750849818;
        Fri, 18 Sep 2026 10:00:49 -0700 (PDT)
Received: from customer.bnssarg1.isp.starlink.com ([2803:9810:8266:bb08:24a9:9eba:f922:f56a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-48739852afasm1404034fac.7.2026.09.18.10.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 10:00:49 -0700 (PDT)
Sender: Mariano Baragiola <mariano.ignacio.baragiola@gmail.com>
From: Mariano Baragiola <mbaragiola@linux.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Mariano Baragiola <mbaragiola@linux.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Anton Danilov <littlesmilingcloud@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] udp: resubmit encap packets for secondary mcast sockets
Date: Fri, 18 Sep 2026 14:00:42 -0300
Message-ID: <20260918170042.609084-1-mbaragiola@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAAVpQUAmGAACd1rBomaY-B2vRiE-VX9u4JRCteVB-940RhRtbg@mail.gmail.com>
References: <20260918153604.579277-1-mbaragiola@linux.com> <CAAVpQUAmGAACd1rBomaY-B2vRiE-VX9u4JRCteVB-940RhRtbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Sep 18, 2026 at 9:21 AM Kuniyuki Iwashima <kuniyu@google.com> wrote:
> Did you see a real problem or is this triggered by an AI report?
>
> https://lore.kernel.org/netdev/20260415203624.4057135-1-kuniyu@google.com/

Hi Kuniyuki,

To be completely transparent: this was identified during a code audit following commit 3cb8d4b9bfeb, not from a production crash report.

I recognize that standard FOU configurations do not typically have multiple listeners on the same port (returning -EADDRINUSE), so this primarily affects multi-socket/SO_REUSEPORT encapsulation scenarios. If you consider this an edge case not worth touching, I am completely fine dropping the patch.

Thanks,
Mariano
