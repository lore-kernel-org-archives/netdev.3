Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854819CCF5
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790569753; cv=pass; b=PQKcCPVHPawbG1ZQ245DALHed2vB8Hjh5nxjrxzQcouvBl0LSWOpOv1ENllwrY8m+ib51IBdlUXKUIOkkWc7aHlF4t5A7mPg4g0u+MXiGS91PGJtcTo1sDC57lWZtDAQguIChQel2OSeCQ8BsddpKHd0Y+pMOdctvtSDWqSe6+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790569753; c=relaxed/simple;
	bh=Cc3Rs/HFoYxnQJtyAWsDpps4zoIxWHTErRApJAjwabU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kzf3NG9Llq0UDSCtCHzBhvQs9ou0dJbrH+l67mmsuLd6DwdM2g6Zz+e9dguFjB1OsZwFOHxMoaVTt3Bh6Uiy5odhG261eFokTeypFBF9sPzE6Ot6PU/kjWk34n1nHthxGPXmEdOhKpsIvq1ic2eRmW3YQj9FrTarVc8BYmDTJFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pXeAuRn+; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXeAuRn+"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a5d8fe88f7so377521a12.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790569750; cv=none;
        d=google.com; s=arc-20260327;
        b=jBFaBVb8/0QhT9X/VKqalWw88ynYwwsBuKApDLk8FW+p3nWUGHyWvFoXhZwMyCxNMj
         ALFEC2AweRdpk2tr6mRAMJLQfx2+rnqdGmLfEs38tpYL5FUSJtFha+epcFHorRYP0Gg/
         2+itfomh6F9wUxMNOgxlJBZaxu5mzl/gpECxe2aPpGPhB8BynkMHbr9zNMQJe++O+OnM
         ry/gPPAYxUzIahER6MayyVs5weN9ZFBMUtbuy4f+kyqKECA+kgpO4l5XBKvZ0ATePwUy
         vD46DKcv7ZeQE0P1uy1J/fVYIIRCgfVCrCIBjm75Wt25Wt9rL0q9E2IUot/I9QErUsXo
         Q2sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cc3Rs/HFoYxnQJtyAWsDpps4zoIxWHTErRApJAjwabU=;
        fh=ABOD6qqroBHxmF70CGyuK+mtWoIzFiE/XlzZNZ0VCgM=;
        b=XLzBeWyIqStr6mEpnTU4pQIsZSEzrWCFOTbnK6Zs5Du0zhaZlPqKR79UVkl3+aM6pw
         fEfESdDYuGX4XUuHbPl+wC/9AY8YZHGiLMmVloUfl/5pqHQE/6vhATHYrDWQ8MQnNefd
         F8WxEHaH1P/yWRBViYU6UD5K8xj0wSGz20A6MoOpd2rJuLwMCLyj37VuhSROD9ge0Oqf
         IDF82mZoXZMBLtS3cAcv4rjlo4x7JTYVfRwzQe85DLEH0XOZyQtcwDMUJY1eGeiLYmI2
         /GPYEp7Oe+nfjnjeDiiKUXXyNifzWhSHaPrRcorF0sIl/hnK84FbIZ5Mb+5GmsRXHtFO
         PvAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790569750; x=1791174550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cc3Rs/HFoYxnQJtyAWsDpps4zoIxWHTErRApJAjwabU=;
        b=pXeAuRn+ddF0PVsymMqgNegnGtg1b4NAlpiPCuZWb0JVmQveDaksMta1+Q44/vX4z4
         NS6HMRtM9oO6PxIr8aU9hrqqfEjpWfV7r7A/mhhvnVHkCS8JUDnz0f1SeHubW+k25th9
         AEQ3+TRnwDhEyqsP85VLQ4MBCQjhGEQ1yvJHBrW02p0Du9YvKmZ3E/r35tAt7PLs1WVB
         oUh5C+nDcI9y3PJiAZ5w0nOZBskz+4ncjzLN9h0VgKCsc32OHgy2mVK5++GsjJME4WRa
         HbdStvGQvFu617YocpzNNzgoiqiBHOWWwYX2sxaiyY1Hn0plWJPNamCVavi4dhMMmU0r
         Efig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790569750; x=1791174550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cc3Rs/HFoYxnQJtyAWsDpps4zoIxWHTErRApJAjwabU=;
        b=PCrNGAZXNxuAChsWgZCgUF29gGBMVGmit83eCjov9X1sJf9YnlAQi2mCsL4/1NO61B
         XQ0VeH8Dv4CPIiUF3lbBDzXPIHMkUDyH1/N7uGqDCB9rnhz3dVPPgB7VwIyNxfn/pOsB
         mkbp5KshxWEi/tkEKzKDvH780wPIaTDlW1x1NomW08HxmQfvJTG4NTvVnhOEAF1byOcJ
         qc6Y61QlglI0+G1Sd/cw/wCfSiccv0P5CexK3xyJDm2FShw6lPyCFkLgU6fJ0yRITenW
         PSZA6Vms+jX9crFTk6/ks+NaZ5JOb4ziiD61jpQ5c3xNSrchgVnqvCjyewhI6Duhj0D8
         4UqQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6VE9WWaTE7QGd/Q6UnJCcwmMYy7f9X4ATlTO7PEXygJfOwgLGidmDxrIS3HvYw4fXLHeTUaA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiQgSgGUB7nF45mp+KO/OY+sQFPwt8H/f0A0tUfeCuanXDgCvG
	cMs4i84F5orpbmCyzBEt3vHIAu3E9mheNxG20NNFyv+tZjCztoAiTOx1Zleo2wxgbjIx33BZnRi
	YBxKYy8cNmTS15id96ixroIsUZT9EamvEZxCxXNCEaAVn
X-Gm-Gg: AYBFou0XG44l/1Dcgx1g+7egliVxNr3KLfNAeik7RHv7CsPBNGKj/qnYgxuUQkzgeac
	pwjY3lfbGhrVdUxLqL9dPnJ+CHUCSYvK+FGnVe/m1mQ077rqCrF6Q+z5nZj4u/Ah+dB+1Z3EUtd
	AUU2UnTLbc5ZCyQsB1+2bBbFqyi0wIkZ79VKLJw+npRAo5tX8PtnbW46I0sTW7UeslDg+jpYeWd
	1szhuNYWwrHRvbluiT0q5XVziPpJen1wcPLBT1Keg9ytifB+VCcCPhv74rzypHhSED13KY31xVF
	7R887EMVtsRgnaleKEf7fqdKDGNAR04vyCq5fFv6ZoBj8RTk6FO70k9pLdb0/w8qm/ssjX2gx4g
	l339gqrwFECY=
X-Received: by 2002:a05:6402:400b:b0:6aa:91c2:63b0 with SMTP id
 4fb4d7f45d1cf-6aae1fb697dmr8030974a12.2.1790569750079; Sun, 27 Sep 2026
 21:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927071520.3693598-1-nicoyip.dev@gmail.com> <20260927150704.62c8c919@kernel.org>
In-Reply-To: <20260927150704.62c8c919@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 28 Sep 2026 12:28:57 +0800
X-Gm-Features: AclHuK-9Q4O620Fsh2sXCA3XvsN6P-GhXbVBeaaDb7-HyX3to4btQrRt88NoqIw
Message-ID: <CAAo+4rV+99b1ZaiA6EnNBAivfbpOtq21wSMJNC9OeQ2wLbHqXA@mail.gmail.com>
Subject: Re: [PATCH net] netfilter: nf_tables: serialize offload stats with
 callback unbind
To: Jakub Kicinski <kuba@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 6:07=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 27 Sep 2026 15:15:20 +0800 Chengfeng Ye wrote:
> > Rule GET and dump requests collect hardware statistics under RCU withou=
t
> > holding commit_mutex. Callback unbind removes entries from the base
> > chain's flow_block.cb_list and frees them immediately while holding
> > commit_mutex, so RCU does not protect the statistics iterator.
>
> Slow down. Please do not submit more than 8 patches for networking
> at a time. You can revise the already submitted patches but since you
> violated community guidelines we ask you not to submit any new fixes
> for a month.
> --
> pv-ban: 1mo

Hi Jakub,

Understood, and I apologize for overwhelming the review queue. I had
accumulated these fixes over time and submitted too many of them at
once. Sorry for not carefully reading the submission guideline.

I will not send new patches to the net or net-next and wait for these
already sent patches to be consumed.

Best regards,
Chengfeng
