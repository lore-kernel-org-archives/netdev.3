Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9F83C872C
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792180061; cv=pass; b=UOK4+T3IaTBhauz5x72zw36WMlcJRp7wXTDU0pWYHpn9tvwYGLisP4pomGMLHQWaptnMOkXwPZ+Dk/mwdNJvag6rATkavw8I9PykntEjTjh01XEzPTw+9eDFYns0Vb5F4uGA9tqZRVHHwiziVydwzal6WnjkVBFt9qjF1mC2uoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792180061; c=relaxed/simple;
	bh=OsxrfJdIwI6/les9N6UKoyK/gkJ1cdVxuLttKjePmP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1Qmk69YqiOwNgQ9uEjbyN0hFn0pImYXg9uvAo6SWr83YFDOAvcZRcG7SbiVmqnL8HIRvj3nzN3aYlBW4W6Wx+N0CGNT4Y/5kT/tHMMsaDadwSTEX1UAcI6fDX3uYGvW63aOBMnNvtOXAqWc+YMDtiSwXDUAHeCwP33pqmaD+mA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VK5zcsHJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N27GwoCV; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VK5zcsHJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N27GwoCV"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GJej953725228
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 19:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vLoUVij4D6Xdoj+d66XdloNJ1a24cAv/lHqAd3GbIW4=; b=VK5zcsHJPmHvIibK
	LFjOfE8gKyh/5KYlEtP9zkL83js+5JTfX0LrTPtTE4z8qcN2skHGbVxbv6fQt6xY
	YsRfkcnQVdT+bYmQlrdZWwQDJ66ITsPLpq0rHbsYu5f8f5Ya4MNOKn42+0kWiyDY
	f2KnUYZ5Vy45KRNsnWY00J29PTsXP0MvSm4gkqQVb7cuXgCo75HHroRYJpTpWpZx
	4ekVt5zZdf7ujocT+hWrF/AudewMGCsnsEw14azhFo2V0jdz6843KszIgOih1iYA
	pD+UCAeVglmhwbKu0+HCdAQpSz4/lfgAKYCdtQADEeIKPqhYizZn94JdN0JZd9qW
	sCWoEA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbq450tau-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 19:47:36 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f1e62510cso72493185a.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 12:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792180056; cv=none;
        d=google.com; s=arc-20260327;
        b=pHvAvGWAd00TtoEmCog9UfunyArJXlziSZqDyUAmgGzwQf84OI5jzZ0VM6FS1uX+mM
         18Fh4yW1JbmINA2ETg84fUq81VEtGcFMf6qnBZrv+JAf/DjXghX5SRi7slcgiConbjXg
         vaOQZkRyl/1xFm1s61UFWgO6bW0G66SnleuLQ2yf5bwLUZ9TmolqINZ5xyii35EGsa5k
         j5MejVrSSCXZ0zPk4/AjI4O4DwOc3E7vU36BnumInREK83ibp5RwIVoom1G0PGjBo8nN
         tWmb2nvZDWjh7y+OaZaTMU4PMM/WTAveiY6hrtR4UsEUhqNdHyfEmSpMAXnN4ocA1Rnz
         GdUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vLoUVij4D6Xdoj+d66XdloNJ1a24cAv/lHqAd3GbIW4=;
        fh=Iwxcx4k4H9jxyoJSk63Cg+gg9Ou4RCuk/+6UkrbptRU=;
        b=m8CYpIXHl/8H7KJDlL4XT6iOmwwQK20v16nms1EXWLOSdoxoR6YlJ/G4ujUFgFkE6H
         WdnbPmplNTMgocPgnsYwM4O4o8/sUVgIMedVxhPtVgpYKtXQw7obwULoGzi1/JFWzaDC
         oTYqrThll+BdjwaTTZl4PkqByWk/M/8gAAVptqk9mmZRYsPVC+yDcQzZ4IiGYCNYWwFK
         81z9wrRa79Ff1eFmhwZjAPuqRdvN3TGYkmSVk0uFkA4tg3CrgR5dxpa/xWCikvtL4SSa
         0HVz1Nc10wFk3HeZuDrnHFRKv/JgCo6lszRuHMYq8GWp2QPQO0FH+I0/SokrKlkhr/Yy
         0UZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792180056; x=1792784856; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vLoUVij4D6Xdoj+d66XdloNJ1a24cAv/lHqAd3GbIW4=;
        b=N27GwoCVhu6fCtnW520+xg4/O5waOSUoU4aOdIup01yjwXC9SvTtM43WRIFoIlysb/
         ZelRSCu2QXZMCOJuYKz3SIYuouVitseD3JJpC7cu+K7Pzs1fSgexshHU9a5vekKHmPGr
         esoVuufURI9c0STO9Md5Uw1hOJJ1CdBhQ/H0JyLJm04JdzlAEZOrlCQV6ep4/LNS7ziu
         oaP6JJlPgSliyXZUsi9PcUic83L/h9Qau+qGl58w39PigGH/8MlUQkfzDxCWcolBe8MW
         E0unY9rCHw83oUM7Xfk+gy7zYHeHQkRlx6oYsNfuhrmVAp2cfgQVxcLMbZleKfz3MUzP
         Jmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792180056; x=1792784856;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vLoUVij4D6Xdoj+d66XdloNJ1a24cAv/lHqAd3GbIW4=;
        b=1OIVRizUutSz1VFav+0IFSl+fHrXFjdmz8Voa4VLfRZDHeZ8B+iouNCFyLv3h6FoFR
         OjVeME9AxkO+BkfE9JKd62jKN7WB5+Db5KYw1DckRvlzMn2qDKeG2bLVFTE/Cu30R6Ys
         77aBhUrJ5jzKnhWxqHievtvpgk+EIo59iH8mp2oe1r6B8OYO15XaCOFV7bM+i3DFvTH3
         vO944nfsCHXi9wwzIBe2NzGTD5285pt6wQfq4/iHqHDlWBuoAg5DyIxo1T+LD59sva3W
         KNCl7PEGzDl0K4Td68UsMnaGES7G731squ6qqj+CBR9fNzZ1p8D6bHSVvIPbuMrSVpLm
         GfUQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4sZw9RlhRIg0hMwkv8cXCQ2H/BJ/RDsw4PuxGk1radatNkW0+x9uqo1v0zCBhj7eSbXRgVJ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMqDZzylUVCun3H8Cdu7YFN1L5MGQb36Pj1ShTeOq7Xa3HaEsy
	+8mj2thaQ3XalWuPWs0N+I/tJypRbpX68SFqRFGngrcxmgpFv8DnJHFBrkN3jbRTA86KIDVuCER
	8fKOyBBafdX2i3l/npnUbjX9QUTmJ6Z4nZH3SZiGNjZ2W80ktz+eyIMrQLBHSktF8B5ied43RZ4
	QPQunXWmcGSwVDNnavYvJ+PCTUtNzjmdZZag==
X-Gm-Gg: AYBFou0Gtpck/rj0idPBAlv1a0fUBbTLfPkUGzAZK6Qk5AUfViiiXd2tBrTlXOXkcDi
	iDCSy6P7wa0pfZR4Qz2GqIWYAbk05ENhcs7IU4/b+Jns54FUmI3Gdis2+CQuaex248SquvywuoM
	eHtdHZqfPaDLzbYnM2HPzFoy8hEL6srpwHBVXIEUPgznjrVnhEVx//4Bq7byFZezTpsuLDz5qWt
	Yae1XFUUNiBtukwpiSI6mDQjza1rOf/3mBIsRXJC0tAk+NdKqknMWE6sp4W3iSofIsariQ2eF4=
X-Received: by 2002:a05:620a:a0d9:10b0:93f:2b23:4824 with SMTP id af79cd13be357-93f2b2369dfmr38733185a.34.1792180055646;
        Fri, 16 Oct 2026 12:47:35 -0700 (PDT)
X-Received: by 2002:a05:620a:a0d9:10b0:93f:2b23:4824 with SMTP id
 af79cd13be357-93f2b2369dfmr38730185a.34.1792180054970; Fri, 16 Oct 2026
 12:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013183500.261229-1-peter.hunt@opengear.com> <20261013183500.261229-3-peter.hunt@opengear.com>
In-Reply-To: <20261013183500.261229-3-peter.hunt@opengear.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 21:47:23 +0200
X-Gm-Features: AclHuK82BVEMNwOOoX7-QLyz02roVe99c3uFgde7R8Y7ar1YoeqPe54ho6qU6oo
Message-ID: <CAFEp6-07eXPbC0Q=UuAMqHF4XKbZQ7X9eEDSFuBp+V_UpFZSpQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 2/2] net: wwan: mhi_wwan_ctrl: drive DTR/RTS
 via the IP_CTRL channel
To: Peter Hunt <peter.hunt@opengear.com>
Cc: ryazanov.s.a@gmail.com, Daniele Palmas <dnlplm@gmail.com>,
        johannes@sipsolutions.net, mani@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: njZITxwhhoYO4lULyLSQG0mjZ6xMo15-
X-Proofpoint-GUID: njZITxwhhoYO4lULyLSQG0mjZ6xMo15-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA3OCBTYWx0ZWRfX89FXkHRMFSXK
 sKN6hFxgN0XVPcK0d+I/BpwO2H41Ro8tY5mqTfNuG/NlmA+STirgdl08g8R9PZWYQUhAXy0A2v6
 poELy8CgjgZ6dqHWNVPyfmQCgfwqzlwIE6yaNr5utmcLpg6Kfsxwnxf6tJ8VtpY4A8c+qzK1N2i
 OC7vqQE4tEZwPLvoNkhSvxWPjtGzPaTYcoiwNFP743zu7b7z8giCldQuYkaavjG1xTV6vhXlLwh
 6J4eFF0iee9sLv3Gu0YEX2lM/313EinQJHa6iGq7+AEmEIqZCULPGD5kPs0DXpfyURxyOT4MbHy
 mBfddQFzx8zX58AMQpH4dAdd8YPg6AnRHyE8vhv4iI5aF4Ky/8AVWT7O/lWAuuYES2oPpz6+qCA
 OcxvDveKZwbJACHdcAj8bEo0aalpwEJOiMMEz83DR10ivjS5KFQOomhfGUlJVqzGGZq6QhkPAsO
 fr1dQjOSc5o+N5mxbuQ==
X-Authority-Analysis: v=2.4 cv=e4GT2qp/ c=1 sm=1 tr=0 ts=6ad27f58 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=t2vznHeBAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=G3Y4Gno3pi7WJKXLtj8A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=V_BghkRpYkFyHJIZkSH6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA3OCBTYWx0ZWRfX//CNMR9OUy7B
 hX15bwifVlxKnlhbdgN1pOJsalZ6/UJv97cR9/bCyMTCA7FOIXlDftyyW0Mi11nrZktuuFWz4m4
 fd/VV1CAbuEFyN6LyGVqEvR0QCEo/Pk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160078

On Tue, Oct 13, 2026 at 8:36=E2=80=AFPM Peter Hunt <peter.hunt@opengear.com=
> wrote:
>
> Qualcomm/Sierra SDX55/SDX65 modems withhold unsolicited AT result codes
> (URCs such as +CREG, and the +DMI OMA-DM/LwM2M session indications) on
> an AT port until the host asserts DTR. mhi_wwan_ctrl exposed the AT
> (DUN) ports but had no way to signal DTR, so URCs never reached
> userspace.
>
> Carry the host serial-control lines to the modem over the dedicated
> IP_CTRL MHI channel, which this module now also binds. IP_CTRL uses a
> separate mhi_driver with its own callbacks so the AT/QMI/MBIM data path
> is untouched; the control-channel device for each MHI controller is
> tracked in a small registry so an AT port drives the IP_CTRL channel of
> its own modem (multiple modems are supported).
>
> The IP_CTRL channel has to be declared in the controller's channel config
> for this driver to bind. For the Sierra EM919x/EM929x this is done by
> commit 83c29a55b89e ("bus: mhi: host: pci_generic: Add IP_CTRL channel
> for Sierra EM919x/EM929x") in the MHI tree. On controllers that do not
> declare IP_CTRL the driver does not bind and ->dtr_rts is a no-op.
>
> The wwan core, with "net: wwan: core: propagate modem control signals to
> port drivers", raises DTR/RTS on first open and drops them on last close
> (if HUPCL is set) for any AT port whose driver implements ->dtr_rts, so
> no open/close handling is needed here. The new ->dtr_rts op lets
> userspace assert or de-assert them via TIOCMSET/TIOCMBIC/TIOCMBIS.
> Received device->host serial state messages are silently discarded; a
> single recycled sink buffer keeps the IP_CTRL DL ring live so the
> modem's transmit path does not stall.
>
> ->dtr_rts is void, following the tty_port_operations model it is
> modelled on. It records the requested state and schedules a per-port
> work item that sends the latest state to the modem, so a burst of
> changes is coalesced into one message and cannot fill the IP_CTRL UL
> ring. If a send fails because the ring is full or memory is short, the
> work retries shortly with whatever state is latest by then, so the modem
> ends up with the final state that was requested. The DL sink buffer is
> requeued from a work item, which retries a transient -ENOMEM so the DL
> ring does not stay empty, and which remove() disables before tearing
> down the channel.
>
> Signed-off-by: Peter Hunt <peter.hunt@opengear.com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
> v10: Send DTR/RTS changes from a per-port work item that coalesces
>     bursts and retries a send that fails with -EAGAIN (UL ring full) or
>     -ENOMEM, so the modem always ends up with the final state. Testing
>     v9 showed that rapid toggling could fill the IP_CTRL UL ring and
>     drop updates (Sashiko review of v9). Loic's Reviewed-by is dropped
>     as the send path changed
> v9: Requeue the DL sink buffer only from the refill work and disable it
>     with disable_delayed_work_sync() before mhi_unprepare_from_transfer()
>     in remove(), so no requeue can race with channel teardown (Loic
>     Poulain, Sashiko review of v7). Leave unpreparing to mhi_probe() when
>     probe fails. Name the wwan core commit instead of "patch 1"
> v8: No changes
> v7: Retry a failed DL sink buffer requeue from a delayed work item on
>     -ENOMEM, and log other failures. Note the dependency on the IP_CTRL
>     channel entry in pci_generic, now in the MHI tree. Both from the
>     Sashiko review of v6
> v6: Rebase onto net-next. Allocate the IP_CTRL DL sink buffer separately
>     instead of embedding it in struct mhi_wwan_dtr, so DMA cache
>     maintenance on non-coherent platforms cannot touch neighbouring field=
s.
>     Do not requeue the sink buffer from the DL callback when the transfer
>     completes with an error (e.g. -ENOTCONN during channel teardown)
> v5: Implement ->dtr_rts(port, mdmbits) and drive DTR and RTS
>     independently. Pre-queue an RX sink buffer in probe and requeue it in
>     the DL callback so the IP_CTRL DL ring does not run empty and stall
>     the modem's transmit path
> v4: Add dev_dbg when IP_CTRL channel is not enumerated for this controlle=
r
>     and when mhi_queue_buf fails, to aid diagnosis of the "URCs missing"
>     case on controllers that do not declare IP_CTRL
> v3: Remove is_at_port, implement ->dtr_rts instead of ->tiocmset,
>     open/close DTR raise/drop handled by wwan core (Loic Poulain)
> ---
>  drivers/net/wwan/mhi_wwan_ctrl.c | 262 ++++++++++++++++++++++++++++++-
>  1 file changed, 261 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan=
_ctrl.c
> index a31d8540fbb8..e3c207588956 100644
> --- a/drivers/net/wwan/mhi_wwan_ctrl.c
> +++ b/drivers/net/wwan/mhi_wwan_ctrl.c
> @@ -1,8 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2021, Linaro Ltd <loic.poulain@linaro.org> */
>  #include <linux/kernel.h>
> +#include <linux/list.h>
>  #include <linux/mhi.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/termios.h>
> +#include <linux/workqueue.h>
>  #include <linux/wwan.h>
>
>  /* MHI wwan flags */
> @@ -14,6 +19,32 @@ enum mhi_wwan_flags {
>
>  #define MHI_WWAN_MAX_MTU       0x8000
>
> +/* IP_CTRL channel message that sets the modem's DTR/RTS control lines *=
/
> +struct mhi_dtr_ctrl_msg {
> +       __le32 preamble;
> +       __le32 msg_id;
> +       __le32 dest_id;
> +       __le32 size;
> +       __le32 msg;
> +} __packed;
> +
> +#define MHI_DTR_CTRL_MAGIC     0x4C525443      /* 'CTRL' */
> +#define MHI_DTR_MSG_DTR                BIT(0)
> +#define MHI_DTR_MSG_RTS                BIT(1)
> +#define MHI_DTR_HOST_STATE     0x10
> +
> +/* Per-controller IP_CTRL channel, used to signal DTR/RTS to that modem =
*/
> +struct mhi_wwan_dtr {
> +       struct mhi_controller *cntrl;
> +       struct mhi_device *mhi_dev;
> +       struct list_head node;
> +       struct mhi_dtr_ctrl_msg *rx_buf; /* DL sink, separate allocation =
for DMA safety */
> +       struct delayed_work rx_refill; /* retries a failed sink buffer re=
queue */
> +};
> +
> +static LIST_HEAD(mhi_wwan_dtr_list);
> +static DEFINE_MUTEX(mhi_wwan_dtr_lock);
> +
>  struct mhi_wwan_dev {
>         /* Lower level is a mhi dev, upper level is a wwan port */
>         struct mhi_device *mhi_dev;
> @@ -35,6 +66,12 @@ struct mhi_wwan_dev {
>          * decremented on data queueing and incremented on data release.
>          */
>         unsigned int rx_budget;
> +
> +       /* Latest DTR/RTS state for the modem, sent from dtr_work so a bu=
rst of
> +        * changes is coalesced and only the final state has to get throu=
gh
> +        */
> +       unsigned int dtr_mdmbits;
> +       struct delayed_work dtr_work;
>  };
>
>  /* Increment RX budget and schedule RX refill if necessary */
> @@ -103,6 +140,80 @@ static void mhi_wwan_ctrl_refill_work(struct work_st=
ruct *work)
>         }
>  }
>
> +/* Signal the modem's DTR/RTS lines over its own controller's IP_CTRL ch=
annel */
> +static int mhi_wwan_ctrl_send_dtr(struct mhi_wwan_dev *mhiwwan, unsigned=
 int mdmbits)
> +{
> +       struct mhi_controller *cntrl =3D mhiwwan->mhi_dev->mhi_cntrl;
> +       struct mhi_device *ctrl_dev =3D NULL;
> +       struct mhi_dtr_ctrl_msg *dtr_msg;
> +       struct mhi_wwan_dtr *dtr;
> +       u32 msg =3D 0;
> +       int ret;
> +
> +       guard(mutex)(&mhi_wwan_dtr_lock);
> +
> +       list_for_each_entry(dtr, &mhi_wwan_dtr_list, node) {
> +               if (dtr->cntrl =3D=3D cntrl) {
> +                       ctrl_dev =3D dtr->mhi_dev;
> +                       break;
> +               }
> +       }
> +       if (!ctrl_dev) {
> +               dev_dbg(&mhiwwan->mhi_dev->dev,
> +                       "IP_CTRL not enumerated; DTR/RTS not signalled to=
 modem\n");
> +               return 0;
> +       }
> +
> +       dtr_msg =3D kzalloc_obj(*dtr_msg);
> +       if (!dtr_msg)
> +               return -ENOMEM;
> +
> +       if (mdmbits & TIOCM_DTR)
> +               msg |=3D MHI_DTR_MSG_DTR;
> +       if (mdmbits & TIOCM_RTS)
> +               msg |=3D MHI_DTR_MSG_RTS;
> +
> +       dtr_msg->preamble =3D cpu_to_le32(MHI_DTR_CTRL_MAGIC);
> +       dtr_msg->msg_id =3D cpu_to_le32(MHI_DTR_HOST_STATE);
> +       dtr_msg->dest_id =3D cpu_to_le32(mhiwwan->mhi_dev->ul_chan_id);
> +       dtr_msg->size =3D cpu_to_le32(sizeof(__le32));
> +       dtr_msg->msg =3D cpu_to_le32(msg);
> +
> +       ret =3D mhi_queue_buf(ctrl_dev, DMA_TO_DEVICE, dtr_msg, sizeof(*d=
tr_msg),
> +                           MHI_EOT);
> +       if (ret)
> +               kfree(dtr_msg);
> +
> +       return ret;
> +}
> +
> +/* Send the latest DTR/RTS state. A full UL ring or a failed allocation =
is
> + * retried shortly, with whatever state is latest by then, so the modem =
ends
> + * up with the final state. Other errors mean the channel is going away.
> + */
> +static void mhi_wwan_ctrl_dtr_work(struct work_struct *work)
> +{
> +       struct mhi_wwan_dev *mhiwwan =3D container_of(to_delayed_work(wor=
k),
> +                                                   struct mhi_wwan_dev, =
dtr_work);
> +       int ret;
> +
> +       ret =3D mhi_wwan_ctrl_send_dtr(mhiwwan, READ_ONCE(mhiwwan->dtr_md=
mbits));
> +       if (ret =3D=3D -EAGAIN || ret =3D=3D -ENOMEM)
> +               schedule_delayed_work(&mhiwwan->dtr_work, msecs_to_jiffie=
s(10));
> +       else if (ret)
> +               dev_warn_ratelimited(&mhiwwan->mhi_dev->dev,
> +                                    "failed to send DTR/RTS state to mod=
em: %d\n",
> +                                    ret);
> +}
> +
> +static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, unsigned int m=
dmbits)
> +{
> +       struct mhi_wwan_dev *mhiwwan =3D wwan_port_get_drvdata(port);
> +
> +       WRITE_ONCE(mhiwwan->dtr_mdmbits, mdmbits);
> +       schedule_delayed_work(&mhiwwan->dtr_work, 0);
> +}
> +
>  static int mhi_wwan_ctrl_start(struct wwan_port *port)
>  {
>         struct mhi_wwan_dev *mhiwwan =3D wwan_port_get_drvdata(port);
> @@ -163,6 +274,7 @@ static const struct wwan_port_ops wwan_pops =3D {
>         .start =3D mhi_wwan_ctrl_start,
>         .stop =3D mhi_wwan_ctrl_stop,
>         .tx =3D mhi_wwan_ctrl_tx,
> +       .dtr_rts =3D mhi_wwan_ctrl_dtr_rts,
>  };
>
>  static void mhi_ul_xfer_cb(struct mhi_device *mhi_dev,
> @@ -224,6 +336,7 @@ static int mhi_wwan_ctrl_probe(struct mhi_device *mhi=
_dev,
>         mhiwwan->mhi_dev =3D mhi_dev;
>         mhiwwan->mtu =3D MHI_WWAN_MAX_MTU;
>         INIT_WORK(&mhiwwan->rx_refill, mhi_wwan_ctrl_refill_work);
> +       INIT_DELAYED_WORK(&mhiwwan->dtr_work, mhi_wwan_ctrl_dtr_work);
>         spin_lock_init(&mhiwwan->tx_lock);
>         spin_lock_init(&mhiwwan->rx_lock);
>
> @@ -252,9 +365,118 @@ static void mhi_wwan_ctrl_remove(struct mhi_device =
*mhi_dev)
>         struct mhi_wwan_dev *mhiwwan =3D dev_get_drvdata(&mhi_dev->dev);
>
>         wwan_remove_port(mhiwwan->wwan_port);
> +       /* Give the DTR/RTS drop from removal one attempt, then stop the =
work */
> +       flush_delayed_work(&mhiwwan->dtr_work);
> +       disable_delayed_work_sync(&mhiwwan->dtr_work);
>         kfree(mhiwwan);
>  }
>
> +/* IP_CTRL channel driver, bound separately so the data-port path is unt=
ouched */
> +static void mhi_wwan_dtr_ul_xfer_cb(struct mhi_device *mhi_dev,
> +                                   struct mhi_result *mhi_result)
> +{
> +       /* MHI core has done with the buffer, release it */
> +       kfree(mhi_result->buf_addr);
> +}
> +
> +/* Requeue the single DL sink buffer so the IP_CTRL DL ring never runs e=
mpty.
> + * This only runs from the work item, so remove() can stop it before the
> + * channel is torn down. A transient mapping failure is retried, other e=
rrors
> + * mean the channel is going away and the next probe queues a fresh buff=
er.
> + */
> +static void mhi_wwan_dtr_refill_work(struct work_struct *work)
> +{
> +       struct mhi_wwan_dtr *dtr =3D container_of(to_delayed_work(work),
> +                                               struct mhi_wwan_dtr, rx_r=
efill);
> +       int ret;
> +
> +       ret =3D mhi_queue_buf(dtr->mhi_dev, DMA_FROM_DEVICE, dtr->rx_buf,
> +                           sizeof(*dtr->rx_buf), MHI_EOT);
> +       if (ret =3D=3D -ENOMEM) {
> +               dev_warn_ratelimited(&dtr->mhi_dev->dev,
> +                                    "failed to requeue IP_CTRL RX buffer=
, retrying\n");
> +               schedule_delayed_work(&dtr->rx_refill, msecs_to_jiffies(1=
00));
> +       } else if (ret) {
> +               dev_dbg(&dtr->mhi_dev->dev,
> +                       "failed to requeue IP_CTRL RX buffer: %d\n", ret)=
;
> +       }
> +}
> +
> +static void mhi_wwan_dtr_dl_xfer_cb(struct mhi_device *mhi_dev,
> +                                   struct mhi_result *mhi_result)
> +{
> +       struct mhi_wwan_dtr *dtr =3D dev_get_drvdata(&mhi_dev->dev);
> +
> +       /* Channel is being torn down (e.g. -ENOTCONN), do not requeue */
> +       if (mhi_result->transaction_status &&
> +           mhi_result->transaction_status !=3D -EOVERFLOW)
> +               return;
> +
> +       /* Modem serial state not needed, requeue the sink buffer to keep=
 DL ring live */
> +       schedule_delayed_work(&dtr->rx_refill, 0);
> +}
> +
> +static int mhi_wwan_dtr_probe(struct mhi_device *mhi_dev,
> +                             const struct mhi_device_id *id)
> +{
> +       struct mhi_wwan_dtr *dtr;
> +       int ret;
> +
> +       dtr =3D kzalloc_obj(*dtr);
> +       if (!dtr)
> +               return -ENOMEM;
> +
> +       dtr->rx_buf =3D kmalloc_obj(*dtr->rx_buf);
> +       if (!dtr->rx_buf) {
> +               ret =3D -ENOMEM;
> +               goto err_free_dtr;
> +       }
> +       INIT_DELAYED_WORK(&dtr->rx_refill, mhi_wwan_dtr_refill_work);
> +
> +       ret =3D mhi_prepare_for_transfer(mhi_dev);
> +       if (ret)
> +               goto err_free_buf;
> +
> +       dtr->cntrl =3D mhi_dev->mhi_cntrl;
> +       dtr->mhi_dev =3D mhi_dev;
> +       dev_set_drvdata(&mhi_dev->dev, dtr);
> +
> +       /* On failure mhi_probe() unprepares the channels itself */
> +       ret =3D mhi_queue_buf(mhi_dev, DMA_FROM_DEVICE, dtr->rx_buf,
> +                           sizeof(*dtr->rx_buf), MHI_EOT);
> +       if (ret)
> +               goto err_free_buf;
> +
> +       mutex_lock(&mhi_wwan_dtr_lock);
> +       list_add(&dtr->node, &mhi_wwan_dtr_list);
> +       mutex_unlock(&mhi_wwan_dtr_lock);
> +
> +       return 0;
> +
> +err_free_buf:
> +       kfree(dtr->rx_buf);
> +err_free_dtr:
> +       kfree(dtr);
> +       return ret;
> +}
> +
> +static void mhi_wwan_dtr_remove(struct mhi_device *mhi_dev)
> +{
> +       struct mhi_wwan_dtr *dtr =3D dev_get_drvdata(&mhi_dev->dev);
> +
> +       mutex_lock(&mhi_wwan_dtr_lock);
> +       list_del(&dtr->node);
> +       mutex_unlock(&mhi_wwan_dtr_lock);
> +
> +       /* Stop the refill work, and stop a late DL callback re-arming it=
, before
> +        * the channel is torn down so no requeue can race with the teard=
own
> +        */
> +       disable_delayed_work_sync(&dtr->rx_refill);
> +       mhi_unprepare_from_transfer(mhi_dev);
> +       kfree(dtr->rx_buf);
> +       kfree(dtr);
> +}
> +
>  static const struct mhi_device_id mhi_wwan_ctrl_match_table[] =3D {
>         { .chan =3D "DUN", .driver_data =3D WWAN_PORT_AT },
>         { .chan =3D "DUN2", .driver_data =3D WWAN_PORT_AT },
> @@ -278,7 +500,45 @@ static struct mhi_driver mhi_wwan_ctrl_driver =3D {
>         },
>  };
>
> -module_mhi_driver(mhi_wwan_ctrl_driver);
> +static const struct mhi_device_id mhi_wwan_dtr_match_table[] =3D {
> +       { .chan =3D "IP_CTRL" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(mhi, mhi_wwan_dtr_match_table);
> +
> +static struct mhi_driver mhi_wwan_dtr_driver =3D {
> +       .id_table =3D mhi_wwan_dtr_match_table,
> +       .remove =3D mhi_wwan_dtr_remove,
> +       .probe =3D mhi_wwan_dtr_probe,
> +       .ul_xfer_cb =3D mhi_wwan_dtr_ul_xfer_cb,
> +       .dl_xfer_cb =3D mhi_wwan_dtr_dl_xfer_cb,
> +       .driver =3D {
> +               .name =3D "mhi_wwan_dtr",
> +       },
> +};
> +
> +static int __init mhi_wwan_ctrl_init(void)
> +{
> +       int ret;
> +
> +       ret =3D mhi_driver_register(&mhi_wwan_dtr_driver);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D mhi_driver_register(&mhi_wwan_ctrl_driver);
> +       if (ret)
> +               mhi_driver_unregister(&mhi_wwan_dtr_driver);
> +
> +       return ret;
> +}
> +module_init(mhi_wwan_ctrl_init);
> +
> +static void __exit mhi_wwan_ctrl_exit(void)
> +{
> +       mhi_driver_unregister(&mhi_wwan_ctrl_driver);
> +       mhi_driver_unregister(&mhi_wwan_dtr_driver);
> +}
> +module_exit(mhi_wwan_ctrl_exit);
>
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("MHI WWAN CTRL Driver");
> --
> 2.43.0
>
