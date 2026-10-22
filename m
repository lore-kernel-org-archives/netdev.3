Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668763;
	b=d5GJjtz4njZ6vf20lDOfZ32/WU2GuS8zBH0eY3TwzSQh5nN0sm2sl6yp8F/lYjehxZuj
	 xHIa52yAGMHsJXxquDQN3M3Oe3zLiz+eENTEj8iiEX2jRWZX3rkR/3PAXRKr54Pro9kD+
	 OKQqq15sdlEn0R1PykXX4x9Q+Qw0bfJ6GwI80KNbhBm7aEjzA+jrtxAwqh4Yj55xFADVi
	 uTjctPgO+uf9J5qg+BEoNGeTj5zMi0VSa/8MPlORsnBwuf5GTQZxVo6cmGw37OgBV4WsH
	 uPcvY3312uutJHvkrooIycN3hgCCHf/JwoCUotca8L/JZT/HKdAeIOIT8W1RmlfVo4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668763;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dXEU4fNstySwei7nZv6T8mycxD11pRJ5qnWjwSzk+X8=;
	b=3uiTAF2jOCZ06ct5xRcYm5g1Q62Dgy09IQRPoUCT1Y0mEyt+DaOmsWQ5Dh0Exhmj/22L
	 AdiAjTp0E7yuYqaNM6ZvwyAkKE45Mr0cc7AUO5ShGgGsrln/LAej8g5tp5ahlnwddLeHT
	 2NSUApNngeKhIapAEC6JK3onO/PCweg29LhvHAhei13JloqlGg0eA1Cnwypkab13EM6v/
	 IY7/Ce7Dr0SjHOUfgH37SMvtBNGRbjOciEkZ+StFI84cFRgRv/PxqLttM7LmqS9ClsNIa
	 lwCBGUKNjoxAohN9lMFoRld+4P/0cYuP8FGNC6j0IVhp2VwVOwqXjIL4/EQHOTguNgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z3TQBkVB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QYG1Xf6G;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6E5606A328
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A6E5606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z3TQBkVB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QYG1Xf6G
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M9xmEU317701
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dXEU4fNstySwei7nZv6T8myc
	xD11pRJ5qnWjwSzk+X8=; b=Z3TQBkVB20a5qG7u5iAzniVCA6vhy+g7rZAljzZj
	mkKDSbpW1JcJKAAZtfFabQV0ZGI7TqWZlqo3AXsayy42gSw7v6g+1gGBw7SjWB+n
	pI/1Oy7K2n9v5746SuqfhYWkIf2AoXKZx7NWoRzDGazf/PJ7zSDG0r8ITgSTVaWD
	X++JFG2o/fpng6QQASI9c5gvT9cyqvFpKlyEjkkUfw+3nMc2lmsStQqjA6rWtVn9
	7IAK52MAkALuckgcBtHxE8bPGBRQdIx6RxR4jgkbaZVBXDtVSD8N2PbN3uacqza8
	ACWxeRJbyW2J468G8zRfklcoM2HtzT0dNPxERQanw7SKTA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ajsyd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 11:32:42 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-14373747468so387118c88.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 04:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792668762; x=1793273562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dXEU4fNstySwei7nZv6T8mycxD11pRJ5qnWjwSzk+X8=;
        b=QYG1Xf6GP63YYCcSETYUUVRYcrLd+SXv8cR6aRb3KCYkvWyZ9y6XMP6DHnmOYLGNGF
         TFDzwUE34a3SyTiYrJJ//r5FIrAAFFvPREKaSzsNRZxYLRcU/5QAyhJXc4F7R5raz1Nb
         M1I7A1erKhkQkJMLXwpri4/femNNkvaNhyGmNivHbhl5J5IiVIedzLHVdGKcI2KSUk8K
         1Ufe2W+v38JrzYqUCuIuk+xdoUJX6T1/JFwB989aRfJVpfYKKJy3yUriQXhxiUPWe85h
         pn4hHnPjyqYsUOrIhK70lm0zx5BzDqmqhO/+RhImbgfD25K7nhNcCcyEX1sfM47jkimQ
         uYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792668762; x=1793273562;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dXEU4fNstySwei7nZv6T8mycxD11pRJ5qnWjwSzk+X8=;
        b=15V/4DVVMHg4aZxs2uURd+qDCuVUwEzkxRMVtLdCjIn9P3Bf7O0J/GA4eoQGIPikR4
         vZhovp4fqb85j5PnqskY5IyzEyU/bU9N5CKyxr9kL3hhjtnCX3y+IJ7ALmH7+2Qeo9Kb
         blE5pxyUYDfFV6aLuFN/nYJ4Ezs0hf5+CrwUCs3O6Y52V2oP5fURxB0I6LsoSKmkoQS2
         veyi56dyaxRINhW2JHyK78ASbpedNeZKm4Q+CQvu5UoXtuC3pM0oYW5FLJttE8i4pJtz
         GWDGdvC86fP0NoeQQVHptYsXvcXIz+LlU4y30H2phTkGPhNlRpLrxeKQpVP0dKtbo0jL
         B/fw==
X-Forwarded-Encrypted: i=1; AKwUvBxwlPOrt/yRQlQ01ioeD977Q+x8hpl25DlDf5emoczQyAs2kmzbCcYH7/EXZyW45yHf03fKzjk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRPMzdIcOxD/7QOj75S/l9eBk6zBMpqNh+FECWGZehwxco8WgU
	hQezQmsggBZha+PdGgRJo5idwuYfWDIaG8jhYf8SLTCpb3f9VD1oLYySl00fKEJH2YYqnW5it4D
	xwvauVXxto8isA8bMIMX1dhW1KWGdQmInzLWlTg8cH6tXg0eAOfE7SKAQqsg=
X-Gm-Gg: AYBFou0b6uHvrVvNqrYvGsyn9JPIafvdlZEPmmXnvF9m/W1Ci9/cPm9MeUHOcUHZRHp
	o/MVC4z+kCjms6zxxkJrEbhNqgNuy+KOxATkfcpTJCUiGRrhS5f0f8yVzo622HvcdvGiQDvP38j
	kg8A4z3t8dNH1EEQ9poUGAnZLGkHubByz96t4LLnL5AhyNyxpNpJeN6Ti7TjYBzwbTj5pA9p4iz
	i4OhsbsLAUL4ln2PEgv7Hahk2YurSqTU3e8ZcIEzj+WazH0ErsvM72rEWd88gfbsvGJGR66YLfu
	4w4UNAPP2IPcZhc3vCuKVwESjVdr7Qv2g1FrAIkX5HzwHOwyoias2uMFPrnL4fy35TODdSr8sAD
	uBqTXgI7OOjlJee/eQ5AYe81TZw==
X-Received: by 2002:a05:7022:fa01:b0:141:5281:8a41 with SMTP id a92af1059eb24-190a4f06512mr7988803c88.9.1792668761592;
        Thu, 22 Oct 2026 04:32:41 -0700 (PDT)
X-Received: by 2002:a05:7022:fa01:b0:141:5281:8a41 with SMTP id a92af1059eb24-190a4f06512mr7988744c88.9.1792668760893;
        Thu, 22 Oct 2026 04:32:40 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-190e29381d9sm12143730c88.18.2026.10.22.04.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:32:40 -0700 (PDT)
Date: Thu, 22 Oct 2026 17:02:26 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Abel Vesa <abelvesa@kernel.org>, Sean Paul <sean@poorly.run>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-media@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 0/8] Migrate PAS clients to qcom_mdt_pas_load() and
 qcom_pas_prepare_and_auth_reset()
Message-ID: <20261022113226.tfuhxqrtfl3c4kcx@hu-mojha-hyd.qualcomm.com>
References: <20260925155737.4161358-1-mukesh.ojha@oss.qualcomm.com>
 <ce3f58f7-f500-49f8-89cd-611d8e1ac6ac@oss.qualcomm.com>
 <20261021130735.h7t2c7txqdfohrs6@hu-mojha-hyd.qualcomm.com>
 <zqu4sweaftstbt26v2u3ajzv7snnqswuyrktm7t7k5gh4zi77e@d6t2fpsinvxc>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zqu4sweaftstbt26v2u3ajzv7snnqswuyrktm7t7k5gh4zi77e@d6t2fpsinvxc>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0NSBTYWx0ZWRfX8vlRe6g8nMVJ
 MnxgPF/BsfWqAYD4oOW8lqZ+pv1L4LPUasp4sbM+6TFkohdRVQPzXvFAKfLm/kFzxIfzR/qa4gy
 W44B8OoftucrSlkZst5n+ORRICd/x7NVvAaD33lcWaMiBWvVU1PWoszDx+1AW74HbDBodHsmbSV
 aiXEJ5UQR9JV+aCxcAqsmHvIUliGw/fCT40HVNuZBNu39fDdh5L5lb0d9tHy5cbEyACttAR879u
 CTef0ejk+TChLwAatxbinAvaL3v8loy5lt8DhvSqK0Th6fYdRbaF7gePxFl2TsIol4tE0dQnb0W
 8nDYvG+IF99fBet9PYLEuuppcIPdl6nfl2qXhJ9pHiaLDq5YbJmy713PmDzcAMTRjUW/wttKenn
 q/RWjTVfyRbY3AEuRZNG4C5+tQeBZ51Y51TCa2AxVoc31KBDWWYx1qQ0rZFtGrYATWCPnT8+yYK
 ygeUImXDforft7W5iEw==
X-Authority-Analysis: v=2.4 cv=H7FOUOYi c=1 sm=1 tr=0 ts=6ad9f45a cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=ZHN8ZsQmYYvh4dXIsskA:9 a=CjuIK1q_8ugA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: 2T3cSyU2112yfqXFZHvLRklSpm54MoCt
X-Proofpoint-GUID: 2T3cSyU2112yfqXFZHvLRklSpm54MoCt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0NSBTYWx0ZWRfX/zfBODX4reFh
 Bs8n6npH+B54L0gPkpCTjElM5NQeOsgkOy6GhObfWnckkTHUYUnK3v5CaaYvSyZ5DBTz+RjjYR2
 1icYyci2TdRH8a+FWyUNGsSDvdYRg2M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220045

On Wed, Oct 21, 2026 at 04:19:59PM +0300, Dmitry Baryshkov wrote:
> On Wed, Oct 21, 2026 at 06:37:35PM +0530, Mukesh Ojha wrote:
> > On Wed, Oct 21, 2026 at 01:32:13PM +0200, Konrad Dybcio wrote:
> > > On 9/25/26 5:57 PM, Mukesh Ojha wrote:
> > > > In preparation to remove qcom_mdt_load() and qcom_pas_auth_and_reset()
> > > > public function, migrate every user to the new PAS context-aware API
> > > > qcom_mdt_pas_load() and qcom_pas_prepare_and_auth_reset().
> > > > 
> > > > This series migrates every remaining caller of the deprecated APIs
> > > > (qcom_wcnss, adreno zap shader, iris, venus, IPA, ath12k) and then
> > > > removes qcom_mdt_load() and qcom_pas_auth_and_reset() entirely.
> > > > 
> > > > This series is based on top of although no dependency as such.
> > > >   firmware: qcom: pas: Make MDT buffer retention explicit
> > > 
> > > LLM has the following comments:
> > > 
> > >  1. Metadata buffer (ctx->ptr) is leaked, and overwritten on
> > > reload, because qcom_pas_metadata_release() is never called
> > > (patches 1-6)
> > >  2. devm_qcom_pas_context_alloc() is called from repeatable runtime
> > > paths, so contexts accumulate until unbind (patches 2, 3, 4, 6)
> > >  3. use_tzmem is never set, so the shmbridge prepare step never
> > > runs on SCM and the commit messages are inaccurate; TEE gets
> > > a real mem_phys/mem_size change
> > >  4. Not bisectable: patch 4 relies on the NULL mem_region
> > > handling that only arrives in patch 7
> > >  5. Patches 3 and 4 don't apply to this tree; iris
> > > iris_detect_firmware() still needs mem_virt after the load;
> > > the base of the series is not stated
> > >  6. Patch 7: NULL mem_region now means "map internally", which
> > > weakens the -EINVAL sanity check
> > >  7. Patch 6: redundant second ioremap_wc() on top of ath12k's
> > > persistent memremap()
> > >  8. Patch 6: ctx is set under one scm_auth_enabled check and
> > > used under another, which is fragile
> > >  9. Patch 2: the context now carries the full region size instead of
> > > the MDT size, which matters if use_tzmem gets enabled
> > > 10. Patch 3: stale qcom_mdt_load() comments remain in
> > > iris_firmware.c
> > > 11. Patch 8: no issues found
> > 
> > Thanks.  Will address them along with Sasiko's one.
> 
> Just to check. Did you verify your commits with the lockdep and atomic
> sleep debugging on?

For this series, I did not.

-- 
-Mukesh Ojha
