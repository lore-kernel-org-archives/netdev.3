Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C697C3988F1
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785681123; cv=none; b=K9mjbiTqnPMa+qSPZC46tpZoh3wQC9UCkV6Nyzjh1cpTMyhvg/rWpvGSO2ocM/Z1x4fK5lMD5aSu4Xu7HqX0IOMWl0ejgbjK+LtL2zarv26tqSx86vkLZZUzLkgNDcRgtTdrNnqXKT3kdDbfQ2qcMyuTbuQDVvL1+RBLa3qWuO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785681123; c=relaxed/simple;
	bh=tErVTLhRpn9K3yAbLj18+M/Uk/AKtJM/VXCZntZFO/U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WkxJNX+5x673+nPNyhzGTuPEmF9iuGcoLBXZMZZMV6YchhOe0mfA66z8Xo+hX3qE11b/OT2IaPWcFAFYdEO56oXoA/KQ3MG0k2PT6YP54ISCie9vcuLxVQA/8S4WN9sqQptUjS/yBUpXrkz7VL/fR8SExp6WIvIXChv+9rzF5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEZjyQwn; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEZjyQwn"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-667b0ced2d3so3835662d50.2
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 07:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785681121; x=1786285921; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rKwVETCTflQeAvgoQt7c+sN1emYEIW3zUJc2lUc+Aok=;
        b=kEZjyQwnNXoYvbAjU9Zo8IrE8Scm4Bw+iHPk/5izPv5qeHzDjVMlSVHvCtqKCJd70t
         fizUU0O71lhwinTfDDxd+z1CAsdKwOCBxsUpu/kYnUhtpRKtExfc6PJOzggetyoy1fCO
         FP5PK1YXVwRS1tmjoGTTNxazDZ6N9ZJshnXOS6Bs3kM+mZcGJDIauDEjaeYOj7pKUl4G
         TnGdjSw24s0qJD2/bpegyIH2SYBWX3Js9wwpsYmYlmPht42XJX7orUggojoax5v/rWnk
         41LoPah8NMP42KVgOV65C5Uj9lSXFs3x5H8LfF7OxZFFew+0WJqBZRp+eb2CsYD47Rwt
         40Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785681121; x=1786285921;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rKwVETCTflQeAvgoQt7c+sN1emYEIW3zUJc2lUc+Aok=;
        b=XQRD4pzIuz3ykGHkMXSVBy4X3s6ZnzwXHGSUXdyWrn5ouiHSXVuBtm0YhezufPVXZr
         Y5rDLPhJo4O2ysVf9Hbc4xM23OFMTBeWME1N06xZyPO4wSH2urvYLUIsXK32LG7T0h0k
         WkeXbTFtUc1K/zRrf+nOVBklj+Ewgn1njEAoL/YfGDoftIvRgbr5RkVehcyiRLosE+Ty
         MADjCPV+1DkyVbnEjmgwEJcIw3WVcZVDlN0p1yv+o6kAjrs6rLaBnLm5h/UmnRYo69ST
         sCyf31zZLIgkNjm/EmeB412b83DS7l6FuGR1m5AvECyBMiuBv/BMTziLHKgg6P0fMXb6
         hPoA==
X-Forwarded-Encrypted: i=1; AHgh+RrVKSm9YowqPR3MZx/vBdby8qUIFPp5ckZL3vU+dZ3pU/25UTBku0RgDQcSZSl4zsUREQ7Fxik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw//JmDpn2YYLJJf5Un/8XEAF2THPdD2bk6mmKxKaiwf/o85F82
	8ETSB43LPIkwxOauUtxTptAaW0W9d0ZakT9obqAjM4+SGYHG9MY9y1cV
X-Gm-Gg: AR+sD10jIz52uVBsN2mQuke5y0wUfl0PYXmCxO+239yjcnk4YgRx/wyDABEMwU9v9K0
	MZnno76E/jVKOn2XDsXkmxjdDnodRhSpGDZqwTUZWwDeYf4YQoDx9n5nM072kXgYDE48Wz4Fsg2
	deTwq4aQP+mG0ixqWayCC9zfuim159q9OA9EUTLSiae00TnZZTqHZetbbh79CkwWl0/kC6jyL0W
	1PAWWKcoSCAvw7/ibeu/P2IwNn5ZfNcFik/+WEHvptl1TAU3+XppqkuP9R3t8vKZHDPgz+zyWuV
	irpqdx20S5d1DclO7E/aJ20niwfAER8Wj7Q2SiSWAU+vWMS19x8+NPIvmhY+bR4kvIXy6yHRRDG
	z6f/mRsfw2NNh9cYQJt+8g1md0tLp/wplVScL8V+BXtR5Q/g/jJiXKNhSOJAay4ZIRyyzr+pqtb
	w7vD3etlx0NqHX8rmiAH7TcnwOpRpxNheeR6tSbMzbh4A4xvSFhPZLAPYaTBj4T1+J34oKcmUH9
	D6rqgpE1060WCay849ZWM0l7JZNzhcmPrfc
X-Received: by 2002:a05:690e:450d:10b0:667:c09c:4a40 with SMTP id 956f58d0204a3-6694f2d9995mr6601702d50.51.1785681120706;
        Sun, 02 Aug 2026 07:32:00 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66948d3f58esm4192692d50.6.2026.08.02.07.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 07:32:00 -0700 (PDT)
Date: Sun, 02 Aug 2026 10:31:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com, 
 joshua.a.hay@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.2f2bc4b192e45@gmail.com>
In-Reply-To: <20260731103137.4000876-1-willemdebruijn.kernel@gmail.com>
References: <20260731103137.4000876-1-willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH iwl-net] idpf: add missing cpu_to_le32 in
 idpf_tx_splitq_build_flow_desc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
> to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
> field in a single operation.
> 
> Descriptors are in little endian. Add missing cpu_to_le32 and cast to
> __le32 to ensure the fields are written correctly also on big endian
> platforms.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")

Forgot the tag. Apologies.
