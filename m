Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792902482;
	b=ohwbIcBN2P4/p0IQ06UxEIQC7oQVBjM4gD+S14GaV9ggc5T8M5ssN7Rud3A8lA71pJ9M
	 NEMz/sv8u2BW9YZ+x8jFM7cXws4rKYeIL+xxDDUMs0KWvat4rhIgXh+Pnv1+Mqb/sl7Im
	 vLnzNCkReb22dqCEskpZLBtbHQ488r8lzxnsntfekYRGiLcq9R1yisOsCTztQ5B+bfkXp
	 8y3oU9EjSSgdsFcNS/BosW+LHTh0eVYrFqmVdKB+L3hWlO4wQOhvKwylMJFstTiPafUf1
	 c3m2gbstY/8ZF+41LqXdsTE5a94r1DD7u5hdqRAFzbfkkZ+eaG31gHyUobKImMciheg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792902482;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=eyQvDd+FH5BWM140ObDNNBQWqnR/utrLDwxacHC587Y=;
	b=LcteBrIyEv65kk3viAOyq8PnPUiBUauDOu7B/HCQFsa8b1gTzCYWxA7JY9txeSnaPDPL
	 m23t2PhM03YNBoYUtP/GeXjcPDdvRUeeC/AAz0n1BpSELOkKXm8uWasgqfe4aX3I7lHg6
	 Tuosph/5HInicI2+yUfWvVKTww28dvG8WzT+2noZwq7j8C2i9Ie8pSc8lPt2W0xt65TOT
	 rcR2ixYYrIs3Msf9U90dRpAgqZiler3B4HAEUV7veEEiki+YQdYTZPVujMDgMTG59eyke
	 oimv+gTo7BcH9E5DBdgYsxXSWDzLjU2zw9qAKy68Rkm0GeffXnE4SXfQX+4hqVN7g6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=bEYmaCiS;
	arc=none smtp.remote-ip=162.62.57.87
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3AA606A31A;
	Sun, 25 Oct 2026 04:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B3AA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=bEYmaCiS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792902469; bh=eyQvDd+FH5BWM140ObDNNBQWqnR/utrLDwxacHC587Y=;
	h=From:To:Cc:Subject:Date;
	b=bEYmaCiSw5QedIwxelzvAvcrrA7f/G5Fo/qD0k29qApmVFlrKXrLnDXNWfOK72DP/
	 katOEX7/Isx+amBZ+WLekMXSCCp66R1dYEjYwsn9bkAQC2hU5cJBwdYjbvfYaQuEcf
	 QxOJm4xZ4ox2duRFip2JpdpPK3QcPjTilhgEHcT4=
Received: from [172.18.4.77] ([61.136.26.103])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 6EF9AC92; Sun, 25 Oct 2026 12:27:47 +0800
X-QQ-mid: xmsmtpt1792902467tgu21mfl4
Message-ID: <tencent_BE912BA710539F285F9FCF28E854ABEFCD07@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahuMEjLm/qfy0hjIryTUW6bb1+hfsdLqzojCcKYmz/y/Wv4PO1de
	 NeDcOgjpFJgbrwPEB5b6WDOuZu/4gxeE/VIfY3rpTjYOAhZHV2nZJm8OhqB+vYnBK61+aJ8CvUIW
	 dNJ0zZu9gxnd18Ajsn1DfNdTwoSpHurvE+++nkI+xB324YKAjBmwJ81GxdHvxTEqaFXPcbCld7/9
	 K8Rr4grWaiIa+GFgdE5leRtrvcVue3I0slXG6hxyMbGce0v9zcvG/bStMnjJVVhN341ZvbCImtnK
	 E4YveNm+4+2hc3f5PC8fsPIECcW4DN+xOfr/NNqOi6zqU6CfEIkoRkZSlKP2fU0iTaDr0MVv5lie
	 ShqPLeHVY75lxeW+IHIF6bL/PS2lUyvIzAP9JAQw2eha4un0wNMSbImvbXtmZaHAnsx9FLpKRGFW
	 O7VK0z268rmO/9DqPEMHgzlO1T90NxKedcc0JgjYbt7sRMqqa8rl0SqnnDjW4fPOk9+o9Amot47E
	 3gbh3dGrSlzIZwUGapOf7bpthU3wD2ruLPaIYxC2Ynx5+ZGzQj5VM30LnkErF/RFgOuHJK7IZKBH
	 cSA7yVNaVEpJ1wdj+QAb/3iiRCwdBR5AjbyAC5S3eS8ByTxdMml9/oU8elVo+g5rJfRG9dPY+REP
	 5L+ABpRTdxeMBWZHjMzSnA8nv2cz1vF6t8UxlKxYI/GYJOCQx77PRYxzpKVamwYv2I2LRLV27pYT
	 e4gqI9cIoFNygIwqZzbQPQPDFUxx+HLIENMg7EpRktB+BMMRPfoKQa8a8iHKjnsYLpbrvDXokKZ3
	 LU3fxpBJs+rcdz3ERft+TiFxsEw5vZZqbwocY5ecJL3sjh9noOfIjD5PVO3XApQg6wr0tbWtD/j2
	 o3oQaXBiqeQbIoyctwvJcZRI3IheNw91N9PObRNhj4Vb5FrnU3cVlqXxt2j4yDbmc//iuITdyAKu
	 GWG/erndMwQdN1kXLXq0+sLfnSldNGVn9fuMOsCTAqdvl1piBAxqu7K5EVG6AkCwhJ6LDVKh1pMu
	 02iVHybLHiMfP+5RE1SG5+l/qyRzwiQi7zJWuWUGSOsCifxJ+DP0Xok2fuHHk=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Guikun Yang <yangguikun19@qq.com>
To: Jiri Pirko <jiri@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG] devlink: region trigger leaks a permanent snapshot id slot on
 every successful auto-id capture
Date: Sun, 25 Oct 2026 12:27:46 +0800
X-OQ-MSGID: <20261024234000.82740-devlink-yangguikun19@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Jiri, Jacob,

devlink_nl_cmd_region_trigger() (net/devlink/region.c) allocates a
snapshot id via __devlink_region_snapshot_id_get() when the request
does not carry DEVLINK_ATTR_REGION_SNAPSHOT_ID, then creates the
snapshot.  On the success path it returns without ever releasing the
caller's reference, so the id's refcount stays at 2 instead of dropping
to the snapshot-only 1.

__devlink_region_snapshot_id_get() is documented as:

 *	Note that the caller of this function counts as a 'user', in order to
 *	avoid race conditions.  The caller must release its hold on the
 *	snapshot by using devlink_region_snapshot_id_put.

The netlink trigger is its own caller, and nothing in the kernel holds
the id after the command returns, so the hold is never released.

Consequences, per successful auto-id trigger:

  xa_alloc(&devlink->snapshot_ids, id, xa_mk_value(1))   /* count = 1 */
  __devlink_region_snapshot_create()                     /* count = 2 */
  ... success, no put ...

Later, when the snapshot is deleted, devlink_region_snapshot_del()
calls __devlink_snapshot_id_decrement(), bringing the count to 1.
Since it is not zero, the id is NOT erased from the xarray:

 *	If the count reaches zero, erase this id from the xarray, freeing it
 *	up for future re-use by devlink_region_snapshot_id_get().

The slot stays occupied forever.  Every subsequent attempt to use that
particular id fails:

  - __devlink_snapshot_id_insert() rejects it with -EEXIST (xa_load()
    finds the stale entry), so a user can never explicitly re-create a
    snapshot with that id;
  - reading or deleting "the snapshot with that id" returns -ENOENT,
    so there is also no way to clean the stale entry up.

Repeating the trigger leaks one xarray slot each time.  The slots are
small, but the ids are allocated with xa_limit_32b and never reused, so
the snapshot_ids xarray grows monotonically for the lifetime of the
devlink instance, and every id ever handed out by an auto-id trigger
becomes permanently unusable.

For comparison, the failure path is correct:

err_snapshot_capture:
	__devlink_snapshot_id_decrement(devlink, snapshot_id);

which drops the caller's reference (1 -> 0) and erases the slot.  The
explicit-API users (e.g. devlink health reporters) also pair
devlink_region_snapshot_id_get() with devlink_region_snapshot_id_put()
and are fine.  Only the auto-id success path in the netlink trigger
misses the release.

Fix is one line: on the success path of an auto-id capture, release the
caller's reference after the snapshot has been created, e.g. right
before the final unlock:

	if (!snapshot_id_attr)
		__devlink_snapshot_id_decrement(devlink, snapshot_id);

(the snapshot itself holds the remaining reference; when the snapshot
is deleted the count reaches zero and the id is erased and becomes
reusable).

Checked against 7.3.0-rc7 and linux-next (2026-10-24): both carry the
leak.  syzbot has no devlink-region reports, and I found no prior
report on lore/marc.

Reproduced on 7.3.0-rc7 with netdevsim (built-in devlink region
"dummy") using an unmodified upstream config:

  trigger (auto id)            -> snapshot id 2 created
  delete snapshot 2            -> ok (slot refcount 2 -> 1)
  trigger with explicit id 2   -> -EEXIST

Repeating the pair three times allocated ids 2, 3, 4 sequentially and
left every one of them permanently unusable.  PoC is a plain netlink
sequence (DEVLINK_CMD_REGION_NEW without and with
DEVLINK_ATTR_REGION_SNAPSHOT_ID, then DEVLINK_CMD_REGION_DEL), no
special privileges beyond CAP_NET_ADMIN.

Best,
Guikun Yang

