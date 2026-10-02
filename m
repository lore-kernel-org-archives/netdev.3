Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9F3C81B9
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975412; cv=pass; b=PxSJ1O/ETJ6tVAKjo3RaTWgJjQ/sXBG2zLH0TouH218ThEJ3OKG7eVotE9/mfIjHK6r7lhNToZPM+XaeFgWH9wq+JLpZW5P4ZAytOyKcqbwIYIbO9QliWkmvzHAeunXj6r9b5h5A6iDlWqS7GDrQOPKg+KXVDJtjYF7uXu4x8IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975412; c=relaxed/simple;
	bh=8ZJ3SbY5N++QU5F2Cm2usCkS6tIxaMnMadqvnXYF9+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hb3G7lB7DtvNbdsCllctul1Ams14ybVaKAyCGZVPxJmOvHyI6b3UwyN7HIjHUr1PDcjEeB8UXJoDwwxaLEXIH81cn/mzv70E9R1QHrN8jQvuewOFlHwEMGy7xAmsv2zrfAjHfth7Yw4xwUIYh3+1ofKljZWFV4MJ5kB722f2ZYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8eRKSxe; arc=pass smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8eRKSxe"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e028ed54dso48304566b.1
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 14:10:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790975408; cv=none;
        d=google.com; s=arc-20260327;
        b=PPzkAdD15h7AYsmYx6WRNoDg0mnL5DVb5QJRITjXHOo66T1S2KzjgK6zDijyP0az2b
         uJl51BSnfLvLmj8qrDo9ZwR9divzAmfd5oH0wS1+VWzl91S+8joftekv//FmMKri5XLd
         uco7rN3EQDbnXD6HHp4+ld5Xud3a9vAB65cH+rnBaz262MiyyU2oR1+MhXfA+bA40bke
         RGIhTGMgQxyOt9gDMK6pGyzvAwbxRgy2HnSiT5sx9KC5lKrEjdSQB2UIcPXPOA5HDtN4
         zQrNzm76DtqgttcIKFN5sUxo8HwfqiYdOKFDnGpWj0n72J79rk44rrzeL6JzirdnzjcB
         SVVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Eg586wb4d7KXht4zgOReRAU6drq3nZvO7SFyjkfsBLY=;
        fh=nZ2SiP2mhWEGSyJ7PORKEE9gjs7j8s1Y5GyAXhFI5hg=;
        b=orUI6sZrCEEnzlvVITTpLSLxWcr2wGtKlgKIyDMw7qQeIMZuUx9wzh6wVTyhHhDtjW
         0nogWVLnfMUd1Dr4CgNiUdp+QYNBsdpRt+S0Uo2c8TXg4mUCevlgsSXO4ZIxW7/sv77T
         COS850toR7SV1g05BWokA34j2pyqjR57+89LgShR8/zAuCPICga3PJigBCI0yeXeMbzX
         qGV03w5O5kBFENc69jjHfEZzDto/hvhDG9QJ9sxUrNzxQyGYjQb/bxIunmjoQBo2M0Xo
         mrKdEIN7nROmOevAF26UOk1wKK2DVuUdldvz5w1Q44/ipQKWPKG6hG1rN8DlcBwzLWJe
         OySg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790975408; x=1791580208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Eg586wb4d7KXht4zgOReRAU6drq3nZvO7SFyjkfsBLY=;
        b=m8eRKSxeDpAbljmEcPcnGBnfZRsqfAQzLLjoBR0P6IBb/iwuJiLZ2Pfv1xxQCGzOqC
         j7Eh8o4pyBDWYamR0wuIVqqVS7jfecp/z49qreSg/YEKB6KTGfoNUHDneeRpXwUeWdxL
         g9vIGXpdnlOiyQmNzhaA8Aa8eX1EbvmoEbLs3nDH4GIrsUqzdJ6zukGn9nfiMGXuIlKj
         jS8Bta17GY1gr0Vti6wVXyW0DgXpe2bg/S4GyL3cAM+E8YUo67R+yfOjy2niRW8fiicG
         wXBrLGW52UBWg2eBzVlm8/ygbmeFlhUQ3CG7uch0REdx+NDL4+T37bwgNEoK4hOrDKXz
         WlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975408; x=1791580208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eg586wb4d7KXht4zgOReRAU6drq3nZvO7SFyjkfsBLY=;
        b=OFpzBNnNd74Gjb9n4ymkWIuWM8RWzrwscztAfD2GYJzWGgqc61m47vo2MrJ95GWtY9
         m9QTJw2hVgA8LRo0GJoLORE5XkZW7HW6yaKDYihVXKYDaC3d4s9fWRqbWLtfCCqWJL8y
         XGQyqqMCBIErPc4PHN2pTNf1otjSfcaOTT1q34gdTkthl9pyANW/RfDiX7JaImGr6hth
         JbpFuxw4dpI2OguAhHZVoYRalt2u3jI9QWOpbNYONniAeHHllDeiMg2sz9X9qbeZgrkI
         aynKzOry0pUiAtxEfgKsoh2QhVOk2xmEM5xOBaW+XH+BnbuTgkSx5/coatLrTHlrqAhw
         an6A==
X-Forwarded-Encrypted: i=1; AKwUvBzSSpJ+HWDuepxoHk8K85ctYaB/w88GDXRIyPgGjb/KmkcPvV1JdO3YFbPnOOKeRSb15jjqtIM=@vger.kernel.org
X-Gm-Message-State: AFuF++nY4D/7OGMSKHoj3ALG9IpkumiPgetzY+tiGGuTmhkOIcOwkJ67
	uAiVflRNanGBX/8aZWRf8/nnrdWH78splH4Qjg8/b5G+Pph5L5UkZp7/txdCPe5CaXJwi3fTcZa
	qDd4MnnJ1SEulcVdS7zcXzdDiN7oGSPI=
X-Gm-Gg: AYBFou0EmyQj8Tycb7RKaVDTNHNx385anMePMh6a/xeI8tm1SAxaYexrB0fwqIU050M
	HdhqlmX/Je9AoUL4awLpouZ03VPhHi8rxv4V51B7PUdk9TUuJyiq6I13HHri/RykYVtPn7MDyA0
	ewSEjYTaS5Pt15NqYyU4t2wV/+kbdx76Kkb/1skVSk76SGwIwxMrhBu2GDrnH352gQ3/0RvSf0Q
	mDiud+OQAnV+GfX+GbNzV0K0w1XmkmdWsZc2o10jTmXNfUV5XZPAQNevUI7g5B9BoxrnB1wtyQr
	kpLyE6/z5BhP2olf0S17lQX7FWDd2hTJen5q8cMtC1mZl5mloZFPpBTkHBPeCgsQcg==
X-Received: by 2002:a17:907:d0f:b0:c2a:c799:d068 with SMTP id
 a640c23a62f3a-c2e4adb732dmr329725966b.28.1790975407894; Fri, 02 Oct 2026
 14:10:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928230429.495442-7-anthony.l.nguyen@intel.com>
 <179072991678.434549.17815320009417499641@kernel.org> <DS7PR05MB73208F63C4605A1D0CBA79268B8B2@DS7PR05MB7320.namprd05.prod.outlook.com>
 <IA3PR05MB22078430E404FAD12912A706298B892@IA3PR05MB220784.namprd05.prod.outlook.com>
 <CANm61jc37jivo=XmRwN8ic8PNJFXZK+6Gsw5VRy=b-oZKpMsMA@mail.gmail.com>
In-Reply-To: <CANm61jc37jivo=XmRwN8ic8PNJFXZK+6Gsw5VRy=b-oZKpMsMA@mail.gmail.com>
From: David Butler <croepha@gmail.com>
Date: Fri, 2 Oct 2026 16:09:56 -0500
X-Gm-Features: AclHuK8DMhH1rcb9yT24q2Red7NG7Tvx2B8cCjG77jHRgbZ29f6RNVpLfBQulAY
Message-ID: <CANm61jf=OTipCihF1JOeCfMePGSJzu5+Y4_KnPZG3k8m1RETmg@mail.gmail.com>
Subject: Re: Fw: [PATCH net 6/6] iavf: cap advertised max_pkt_size at the
 single-buffer HW limit
To: netdev-bot+sashiko@kernel.org, anthony.l.nguyen@intel.com, kuba@kernel.org
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@kernel.org, 
	andrew+netdev@lunn.ch, netdev@vger.kernel.org, emil.s.tantilov@intel.com, 
	luoxuanqiang@kylinos.cn, bryan.fraschetti@canonical.com, 
	tristan@talencesecurity.com, tomasz.lichwala@linux.intel.com, 
	horms@kernel.org, aleksander.lobakin@intel.com, stable@vger.kernel.org, 
	jacob.e.keller@intel.com, aleksandr.loktionov@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> [Severity: Medium]
> Should netdev->max_mtu be clamped to match?

Yes, the review feedback is valid.  The bug outlined by the review is
where the user sets an MTU
in the 9728 to ~16356 range and frames above 9728 are silently dropped
instead of the MTU set failing.

We should still move forward with this patch but reword the commit
message.  It will likely be at
least several weeks before I will be able to acquire and setup a lab
environment for reproduction
and testing for a new patch revision.  This patch as-is does not
introduce any code regressions.
In every case the behavior is unchanged or strictly better.
Practically speaking, most users would
not be impacted by the frame drop.  Standard jumbo (=E2=89=A49728, e.g. 900=
0)
is entirely unaffected.

Since 5fa4caff59f2, E810 + ESXi icen + SR-IOV has been unusable: the
VF never finishes
 CONFIG_VSI_QUEUES, regardless of MTU.  The effects are not contained
to the guest
that triggers it. Under pass-through the mis-programmed queue can
raise an IOMMU fault that
 wedges the PF/VF on the ESXi host.  This usually takes out that
interface for subsequent
guests too (even if they have this patch).  Recovery requires a host reboot=
.

A follow-up to adopt the reviewer's fix is warranted.  I can provide
the patch if someone else
thinks they can test it sooner than I can.

A revised commit message follows:

iavf: cap advertised max_pkt_size at the single-buffer HW limit

Since commit 5fa4caff59f2 ("iavf: switch to Page Pool")
iavf_configure_queues() advertises max_pkt_size to the PF as:

        max_frame =3D LIBIE_MAX_RX_FRM_LEN(adapter->rx_rings->pp->p.offset)=
;
        max_frame =3D min_not_zero(adapter->vf_res->max_mtu, max_frame);

LIBIE_MAX_RX_FRM_LEN (16382) is the multi-descriptor scatter/gather frame
ceiling, not a single-queue value, and it exceeds the E810 MAC frame size
maximum of 9728. Per the E810 datasheet (613875-009 section 13.2.2.17.1)
the Tx frame-size register PRTDCB_TDPUC.MAX_TXFRAME has a maximum of
0x2600 (9728); larger frames are discarded. The in-tree ice driver encodes
the same value as ICE_AQ_SET_MAC_FRAME_SIZE_MAX (=3D=3D LIBIE_MAX_RX_BUF_LE=
N =3D=3D
9728), and the VF clamped max_frame to IAVF_MAX_RXBUFFER (9728) before this
commit.

When the PF advertises vf_res->max_mtu as 0, min_not_zero() leaves
max_frame at 16382. The Linux ice PF advertises max_mtu =3D port MAC frame
size (<=3D 9728), so a VF behind ice never sends more than that. The ESXi
"icen" PF on E810 advertises max_mtu as 0, so the VF sends
max_pkt_size =3D 16382, which icen rejects while programming the queue
context for VIRTCHNL_OP_CONFIG_VSI_QUEUES (opcode 6):

        icen_ConfigureTxQueue: VSI 8: Failed to set LAN Tx queue context fo=
r
                               absolute Tx queue 64, Error: ICE_ERR_PARAM
        indrv_SendMsgToVf: VF 0: Failed opcode 6, Error -5

        iavf 0000:03:00.0: PF returned error -5 (IAVF_ERR_PARAM) to
our request 6
        iavf 0000:03:00.0 ethX: NETDEV WATCHDOG: transmit queue N timed out

The VF's queues never come up; under SR-IOV passthrough the mis-programmed
queue can also trigger a fatal IOMMU fault in the guest. Forcing only
max_pkt_size back to 9728 (and leaving the Page Pool rx_buf_len/
databuffer_size untouched) makes the VF come up; databuffer_size is not
involved. This was confirmed on two E810 NVM versions (3.00 and 4.51) under
icen, so the trigger is the icen PF, not the firmware revision. Reported by
several users on E810 + ESXi icen with v6.10+ guests:

Link: https://community.intel.com/t5/Ethernet-Products/E810-C-iavf-driver-i=
ssue-on-Linux-6-12/m-p/1737490
Link: https://access.redhat.com/solutions/6973766
Link: https://knowledge.broadcom.com/external/article/404315/sriov-enabled-=
vms-network-adaptor-goes-d.html

Cap max_frame at the single-buffer HW limit (LIBIE_MAX_RX_BUF_LEN, 9728) so
the VF advertises a max_pkt_size the PF can program into the Rx queue
context. This is the value the VF used before 5fa4caff59f2 (IAVF_MAX_RXBUFF=
ER).

Note this only caps the advertised max_pkt_size. 5fa4caff59f2 also raised
netdev->max_mtu to LIBIE_MAX_MTU (derived from the same 16382 ceiling); whe=
n
the PF advertises max_mtu =3D=3D 0 that leaves max_mtu above 9728, so an MT=
U in
the 9728 < mtu <=3D LIBIE_MAX_MTU range can still be set while frames above
9728 are dropped by the queue context. Clamping netdev->max_mtu to match is
left to a follow-up.

Fixes: 5fa4caff59f2 ("iavf: switch to Page Pool")
Signed-off-by: Dave Butler <david.butler@appgate.com>
Cc: stable@vger.kernel.org # v6.10+
