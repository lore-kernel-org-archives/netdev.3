Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792492015;
	b=rav10In9GmieQEAY6xOkiLeFrtDSWMKHatED61cppCrxo2e6nWnVWsq5jzbT64wHiyAJ
	 6tCcdcN7OjPOs+nKN54VG+BhW5ck2UUONMAiiTRzsJejtxvHEH+uuy4M0Wo7ThLgAsUU0
	 KJrLiN3ZKaFBjZih5gVdiBFSNdD+dQuH6ltPGlCv4mUK9/VC1XpIsJNWmZ/9YyoeHoq6w
	 YinVWkCROTaUwyXEXCmiZKp7mCf7bpYOWXcQw2vdAMWkG2l/HwHnPxbD+NXRtx7KLZAQK
	 3SnEedruN50f7VLLGp1rQAtg+PuZPfmkA6EmNyGeL3RVaQ3f6x4Je0LjLjWsLBXFp3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=EHu9OWyHCYQOt2qT53IJOKTu9rnDJwEoiNY3WIDTNJw=;
	b=TCgLd5Oipfy4aKWRo9MR4jwQbDZdwzjJncTOEsYaOCzwFs/ta65/zf3evAUtHlySCFI0
	 KXkoxN1ZyQYAkY8L5h2hNd1VNJ96xBkM57Le+Mg9JC5UsQfqF3I7po6o+RqIqqo4j0QKm
	 QvMI4KJIDLJGdvQ8aGjtgO6aWBPGiuRYrLtXQVTJur7YF2P2H1WNILO47ZYbtUpDYiev7
	 n19vfySR24gxk+W1UAyxUeeiJoBGcOuV2f4n2mTiENHy23Kz1Z1YeWt9LSJyDoMG6TnNp
	 riAJOwOtZgKJmFQQpzX5LxZxAjkd8jOkYxrInqiTJVtid8F9xhqiBhrE+93Idj5JHLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=o9AFjjEr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD75606A31E
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 10:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CD75606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=o9AFjjEr
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ccce6d9abfeso2095085a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 03:26:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792492015; cv=none;
        d=google.com; s=arc-20260327;
        b=niV95RWOY9f6Ke7CKSgQYwMPjjTq86m6Vo07BcTjKxkATGx8+sHmabMAXqdgFP1aXi
         wC6qNxvocVcl/EAo1kCaQ1IhNq5rFx58zIteS2sbCPATWTzWAQwP4U9gE24zhL0DHQc8
         DZ15DYUKodoMi8HGHIrtZ8YqcwFuwiki9U+dTGmbkyGS7WMdPS9nJWe4I+1VLhD9gcTB
         am6SatQAAvfKLowbtFcD0AnUrPB45W9Y7BfH+KJwb6LKv5BpyDC0AwYBqkMVsY0NDTLZ
         2o6jdGwMIXLxkQEw3kSzzLzn9KNNV10Kzh476BnIUbHCOX6sUj8LqPxCNIKftULY+1Wi
         JSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EHu9OWyHCYQOt2qT53IJOKTu9rnDJwEoiNY3WIDTNJw=;
        fh=Pf2jx/fDVPKwjm3pqqIqkBPEkE+u1WZ+Nawe80Sebh8=;
        b=UuD8KVthODxicJTVNFpnXkle4yd2yg6XCv5M8Cmwa0Fcr+eq2g7oYDI9IVZ2CMJUNp
         3rphTe4fHR2Q3amMizcjMc/7Eb0/gxlKBw3WV3KdqjYBLGO0u7Omkir6ZxsN8kq5msFD
         urIh0JZUbK12ASqulUfrKqIV2t8dSN4mTpP83UzwyY7Hbl7ewndkdCWIdSodx4wK3SYc
         Az+BWY6JbROU/JEAZNswbdl/i0o2uN6epkUZNRWsrUuIfmb+p/26XWsJxgL4aRY41AlS
         Warb4dMgwl0rCBVqD+FHAazx+CyhXfQgWYh7CzeHHRYKMoqd2q/Q4fQDLQiO9H0vzygr
         cCIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792492015; x=1793096815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EHu9OWyHCYQOt2qT53IJOKTu9rnDJwEoiNY3WIDTNJw=;
        b=o9AFjjErLSgOk8N/zevDeBsLl78ZdWDy3lyuN91Tkeqj3Bm7pigFcLtxOJLb2OPptZ
         xtSi2czVZSmowJ4TIlFZmx3ywvC16rKGTukmHKa1WfynCSPL7l2kCG9q1QA6NO9kCOIj
         3PelFBmhd+9mjRVVjAdX88vXdGOCZTEDXmm38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792492015; x=1793096815;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EHu9OWyHCYQOt2qT53IJOKTu9rnDJwEoiNY3WIDTNJw=;
        b=PxhzEIW3kjRQIkOvKmMFsaD6R4345ibyS11dVtnZhfOkON1vByOoU38Ne5JFU+//jX
         ck9BYujB27vvueUhTBQNNNtIjyJbdEXQxx9FkRXHBH6+zCG+osvBOXmpQb2V5K5Vol+n
         PinonFH6qy3379EpyHAZnFB71CVVseHDSbT9t/U++gHQ31iVahixVL1J16T/zBBuiU2V
         QRCxWLyc3xrvNY9W7MirAoCJGuJlvnPipd0P7ECyqY4HJdW400Oh2s8giO0TjpZNhyZd
         rhIwJCtBtbbPi4lbJnnclNEmv3wTA0Yo0ZwqyzLNFtZGdE+C/TawdPbR71A3OZ10YBRy
         egAQ==
X-Gm-Message-State: AFq9FYKRoLpII6FvgpL4KIzzaGG6jxsA17IvfVjHwBwkIva3mXBYqdyt
	LUSfHBsZl0edLxVjpfylDQrsvLQfh/YiUjaOmVcbHnPe3bDJNbawBPhWbf2tgETegnMs7FF9dAT
	byNO0osSJCVB9ICxf9XVu3+KCv1/jriCm9joxmZu7
X-Gm-Gg: AYBFou2SEUJKGwn0jz+AJAP6fCtZmcxszFt0U3p5ladHXHviKPY7U3CEmllOpzCmIF0
	c1PFI0RDibhnXHIU5B67HQtw9EC8U7FNHAArdXqF5fbUfE0PpZESFbYXR2Dt2uXDQwEduZtOjQH
	Q1DoeGibBTZhFicwIvJcFPa5QIydpbYRUp9huisM6o0dE7xV9D8AOtIKde0aR8bfkWeI3jwCSXl
	5ziFjf6kgKS1ChO91/fHFoTFIjNhdrDYTV/A4rv/WklvrfwzREuPQH7wuTGxo70NN7vwtTtGI+p
	JnKzUv+DCaTtCiPCezSYRHCNFSslrHfhthl6kVuF74GXhKQlf3c740+2mmFFNrqJ6GwOVQD+tHZ
	cSmw7ApcZIDDM9/wE//yP/w96eVgsYtkFeQo0eLuC/J8BVTCiTV+ZBbu/T49cO44fhr3JsjzMjB
	2NslCcQDYzdzzyMQw=
X-Received: by 2002:a05:6a21:b89:b0:3e2:1a3e:395c with SMTP id
 adf61e73a8af0-3e2260fab05mr8114467637.59.1792492014703; Tue, 20 Oct 2026
 03:26:54 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v1.r1.20261012134711-1@mojatatu.com> <20261019194019.4b778671@kernel.org>
In-Reply-To: <20261019194019.4b778671@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 20 Oct 2026 06:26:41 -0400
X-Gm-Features: AclHuK9w4N--2-RJIEl8VBx-0rkjIVFOVYul8Lm3ZHkR3c1K0BlS8cEin8kt8kM
Message-ID: <CAM0EoM=iL9kpU6Ju_9=9Frg4sSbD0OMtbQxwYva607259WBXhQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2 repost1] net/sched: sch_teql: fix shared headroom
 and header strip on slave retry
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	sashiko-bot@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 10:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 12 Oct 2026 14:16:27 -0400 Jamal Hadi Salim wrote:
> > Subject: [PATCH net 1/2 repost1] net/sched: sch_teql: fix shared headro=
om and header strip on slave retry
>
> not correctly threaded, again..
> patch 2 should be in reply to patch 1

Thanks for catching it - will resend. I fixed the scripts so this
doesnt happen again, but looks like this one went out before i did
that.

cheers,
jamal
