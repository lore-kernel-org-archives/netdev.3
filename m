Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FA13264C3
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790941958; cv=none; b=tGnkARfeTxsdHhRQeA4+58hRi1r718SywkRF6wzRe4FLk+7avVCDRXmAvazA9Z7vv7dv3KJjB7rqH6DTAypnvWCNK8Shtl2tOcdCSNSbrlLoGI+jszdYJhnkh1RqgdRf5CARY71P0jLWYWeiTJKS4yveqfthh1HgoUZz5XiRxbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790941958; c=relaxed/simple;
	bh=ZK9W3hsM2fdrVPBcEDof+c76PwgAD673MJ5we/sTLcY=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=EQG57itjrp1jGcepAC3xLIfkV5NjFrDjCIZEvMP059QVs1qLGbJvW/Ia8uKKXDXnNUnT1A2ll9K2JX6rga/5y5xijH4c0/gYITV4/Z64+vCA8MMeJ0+Mny+4fEqRwAwDv0iK0Pp4ZR2DXfqFVnt24IYPEILVQVF6TJfdFl0VYjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goUZhIQh; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goUZhIQh"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2e4bc397f2aso1330355ad.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790941957; x=1791546757; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZK9W3hsM2fdrVPBcEDof+c76PwgAD673MJ5we/sTLcY=;
        b=goUZhIQh6T+xmwIT0+JB8OE4Ev2OI+W1B1QvQnPrnbR4slXdPrPelMISBWuSzgq6s6
         2dHWd80pi6Da/Wc1oPU8moB+YkJcefrFFNBlO39OKA0JJW8LnnRgjgh52sbJGZ8FA7Zz
         qBnOwhch0DJOheBhxxTpHc2qMlPLPTBchZNn0TftYojJ70SvDSKxH4yvqWBnRRgcFT3Q
         ibJ8vy9N69AdrrwLYfCrKX6qk8JEBPLy2Ol3Q+xTxZOGeVaBLJs9dcm2pPe0YubjiG10
         oNTQgOQcEQVYORzdIiwZ+Xg5noc5m30zNqOHklur/cGMMFu3Njf5VhoWdxMOS0gkRjQE
         n9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790941957; x=1791546757;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZK9W3hsM2fdrVPBcEDof+c76PwgAD673MJ5we/sTLcY=;
        b=g87ldf0RQSJLoPLO78dpw+guQ7SxT6hqBcVduUYb1pm5fuZmLTU1gTRS9dtGoim/Ba
         rz5En5vr8NMvs0aQA1aJvK0336RhoZbmsM3UuJoXD/GDGtk1wqMtcgwOU79aUaGCq4rM
         FzzLn6FeNU30w3ttzxQkmgegYGFzvHzfV5B7yFWe+Mtm8OaTNFV6ddJ6YCuWhpTy2Jb0
         PfMWA98iva+YG5Ci2HS44Mn0+5JMsJwc4hKSUWRUFaLLc4tpL1ePncvMPhoUY28QuSvi
         YnH1U7PqYdYtpbr0UWoEpg9rBTaFd6U48o7y4TUMegf62aIgn94bRNj5ls0icLFLG84Y
         zC3Q==
X-Forwarded-Encrypted: i=1; AKwUvBwyheWPNSthkzeZ/m7hogxrO6nljli1Ew/1U/R7FzA/PFE/PnNgTetEL3JlLQ09jlpgDVEUH+A=@vger.kernel.org
X-Gm-Message-State: AFq9FYK76jqYOvl9e9O9EUkk5Xo8qkqhPPjkSiBenys1NvR6xbYWXX0R
	A99sOW19/WOa+MlgKaHC2dT3OGJrWFZ///B9QpZw06bZa5+7rkdr7fcq
X-Gm-Gg: AYBFou3XwW3dvcS/5y3xwR9p6vXbnBiSXDzD7xRZZNeYJfTa4ct2KvU3gm6gQiequvi
	woWFlQlwGTG1xBj16YRySDuIaG+eekn9NSxmoH+6VKsB9Z9Jw1ISPRn/T1iLecE4rdLSNc1ONPU
	cO0Uo4iuVMAVHrDG7Q74sG/0m71SOWOOJ8H6qGgFJu9XfPDI1xOJGQFJpXDtlLaNXwIwWX3f/un
	10haDSKI5EIw037m+qYfAkg4x8fC/s7fhpm5l/4u7mMS/AuK7wnDFSA1VuGxAnjm91Je32zDXmM
	lOaUrPkBnh73IdOEQy0KefQSUIOLdyQmzqQITSoVzAi9OgOKYsKcb+oxdxNa95UEXWNz2LTpQNR
	obRDxgvD1DiuqhXdYdFubEjnHuD9SV2VxvMvGU3Maqez2xZMq8S/G0DCXl+20bmfprGO7pFmUQ9
	ZRnRdE4w3cOXXA66n/ec1+T27shPv54dzAmB2CFhAXzxW0jPIIGOWaX/RbZs/2IIJh2l5craSiC
	yUZtSDJPuiHJjcnPSKGgl0d9yLeR9nsaU2XWE25aEWNMDw5L3DZX/YCQ9vE+ZdcUfBIZEB2OW8+
	DWI=
X-Received: by 2002:a17:902:f686:b0:2e3:ca8:7860 with SMTP id d9443c01a7336-2e49b6436c6mr22785045ad.22.1790941956649;
        Fri, 02 Oct 2026 04:52:36 -0700 (PDT)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6aea8csm6628535ad.35.2026.10.02.04.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 04:52:36 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 11:52:35 +0000
Message-Id: <DLUBXS5ZYG1R.1NA6CW88YS5TM@gmail.com>
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>, <daniel@iogearbox.net>,
 <davem@davemloft.net>, <kuba@kernel.org>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <shuah@kernel.org>
Cc: <sdf@fomichev.me>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: add XDP test for per-flow
 LRU_HASH window updates
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261002053837.3494918-1-anilkaushikwireless@gmail.com>
References: <20261002053837.3494918-1-anilkaushikwireless@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 02, 2026 at 05:38 AM Anil Kaushik <anilkaushikwireless@gmail.com> wrote:
> The LRU_HASH selftests (test_lru_map) exercise BPF_MAP_TYPE_LRU_HASH
> only from the syscall side. There is no coverage of an XDP program
> updating an LRU_HASH map on the data path: inserting an entry with
> BPF_NOEXIST on first sight of a flow, then updating a bounded array
> inside the map value using a runtime (modulo) index.
>
> That pattern is common in XDP flow-tracking programs and stresses two
> things worth testing together: the verifier's bounds checking of a
> value-internal array indexed by a runtime value, and per-flow key
> isolation in an LRU map driven from XDP.

Sorry, don't see the value in this test. LRU is already covered.

pw-bot: cr
